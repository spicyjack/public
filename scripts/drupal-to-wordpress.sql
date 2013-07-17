# DRUPAL-TO-WORDPRESS CONVERSION SCRIPT

# Changelog

# 07.29.2010 - Updated by Scott Anderson / Room 34 Creative Services http://blog.room34.com/archives/4530
# 02.06.2009 - Updated by Mike Smullin http://www.mikesmullin.com/development/migrate-convert-import-drupal-5-to-wordpress-27/
# 05.15.2007 - Updated by D’Arcy Norman http://www.darcynorman.net/2007/05/15/how-to-migrate-from-drupal-5-to-wordpress-2/
# 05.19.2006 - Created by Dave Dash http://spindrop.us/2006/05/19/migrating-from-drupal-47-to-wordpress/

# This assumes that WordPress and Drupal are in separate databases, named 'wordpress' and 'drupal'.
# If your database names differ, adjust these accordingly.

# Empty previous content from WordPress database.
TRUNCATE TABLE wordpress.wp_comments;
TRUNCATE TABLE wordpress.wp_links;
TRUNCATE TABLE wordpress.wp_postmeta;
TRUNCATE TABLE wordpress.wp_posts;
TRUNCATE TABLE wordpress.wp_term_relationships;
TRUNCATE TABLE wordpress.wp_term_taxonomy;
TRUNCATE TABLE wordpress.wp_terms;

# If you're not bringing over multiple Drupal authors, comment out these lines and the other
# author-related queries near the bottom of the script.
# This assumes you're keeping the default admin user (user_id = 1) created during installation.
DELETE FROM wordpress.wp_users WHERE ID > 1;
DELETE FROM wordpress.wp_usermeta WHERE user_id > 1;

# TAGS
# Using REPLACE prevents script from breaking if Drupal contains duplicate terms.
REPLACE INTO wordpress.wp_terms
	(term_id, `name`, slug, term_group)
	SELECT DISTINCT
		d.tid, d.name, REPLACE(LOWER(d.name), ' ', '_'), 0
	FROM drupal.term_data d
	INNER JOIN drupal.term_hierarchy h
		USING(tid)
	INNER JOIN drupal.term_node n
		USING(tid)
	WHERE (1
	 	# This helps eliminate spam tags from import; uncomment if necessary.
	 	# AND LENGTH(d.name) < 50
	)
;

INSERT INTO wordpress.wp_term_taxonomy
	(term_id, taxonomy, description, parent)
	SELECT DISTINCT
		d.tid `term_id`,
		'post_tag' `taxonomy`,
		d.description `description`,
		h.parent `parent`
	FROM drupal.term_data d
	INNER JOIN drupal.term_hierarchy h
		USING(tid)
	INNER JOIN drupal.term_node n
		USING(tid)
	WHERE (1
	 	# This helps eliminate spam tags from import; uncomment if necessary.
	 	# AND LENGTH(d.name) < 50
	)
;

# POSTS
# Keeps private posts hidden.
INSERT INTO wordpress.wp_posts
	(id, post_author, post_date, post_content, post_title, post_excerpt,
	post_name, post_modified, post_type, `post_status`)
	SELECT DISTINCT
		n.nid `id`,
		n.uid `post_author`,
		FROM_UNIXTIME(n.created) `post_date`,
		r.body `post_content`,
		n.title `post_title`,
		r.teaser `post_excerpt`,
		IF(SUBSTR(a.dst, 11, 1) = '/', SUBSTR(a.dst, 12), a.dst) `post_name`,
		FROM_UNIXTIME(n.changed) `post_modified`,
		n.type `post_type`,
		IF(n.status = 1, 'publish', 'private') `post_status`
	FROM drupal.node n
	INNER JOIN drupal.node_revisions r
		USING(vid)
	LEFT OUTER JOIN drupal.url_alias a
		ON a.src = CONCAT('node/', n.nid)
	# Add more Drupal content types below if applicable.
	WHERE n.type IN ('post', 'page', 'blog')
;

# Fix post type; http://www.mikesmullin.com/development/migrate-convert-import-drupal-5-to-wordpress-27/#comment-17826
# Add more Drupal content types below if applicable.
UPDATE wordpress.wp_posts
	SET post_type = 'post'
	WHERE post_type IN ('blog')
;

# Set all pages to "pending".
# If you're keeping the same page structure from Drupal, comment out this query
# and the new page INSERT at the end of this script.
UPDATE wordpress.wp_posts SET post_status = 'pending' WHERE post_type = 'page';

# POST/TAG RELATIONSHIPS
INSERT INTO wordpress.wp_term_relationships (object_id, term_taxonomy_id)
	SELECT DISTINCT nid, tid FROM drupal.term_node
;

# Update tag counts.
UPDATE wp_term_taxonomy tt
	SET `count` = (
		SELECT COUNT(tr.object_id)
		FROM wp_term_relationships tr
		WHERE tr.term_taxonomy_id = tt.term_taxonomy_id
	)
;

# COMMENTS
# Keeps unapproved comments hidden.
# Incorporates change noted here: http://www.mikesmullin.com/development/migrate-convert-import-drupal-5-to-wordpress-27/#comment-32169
INSERT INTO wordpress.wp_comments
	(comment_post_ID, comment_date, comment_content, comment_parent, comment_author,
	comment_author_email, comment_author_url, comment_approved)
	SELECT DISTINCT
		nid, FROM_UNIXTIME(timestamp), comment, thread, name,
		mail, homepage, ((status + 1) % 2)
	FROM drupal.comments
;

# Update comments count on wp_posts table.
UPDATE wordpress.wp_posts
	SET `comment_count` = (
		SELECT COUNT(`comment_post_id`)
		FROM wordpress.wp_comments
		WHERE wordpress.wp_posts.`id` = wordpress.wp_comments.`comment_post_id`
	)
;

# Fix images in post content; uncomment if you're moving files from "files" to "wp-content/uploads".
# UPDATE wordpress.wp_posts SET post_content = REPLACE(post_content, '"/files/', '"/wp-content/uploads/');

# Fix taxonomy; http://www.mikesmullin.com/development/migrate-convert-import-drupal-5-to-wordpress-27/#comment-27140
UPDATE IGNORE wordpress.wp_term_relationships, wordpress.wp_term_taxonomy
	SET wordpress.wp_term_relationships.term_taxonomy_id = wordpress.wp_term_taxonomy.term_taxonomy_id
	WHERE wordpress.wp_term_relationships.term_taxonomy_id = wordpress.wp_term_taxonomy.term_id
;

# OPTIONAL ADDITIONS -- REMOVE ALL BELOW IF NOT APPLICABLE TO YOUR CONFIGURATION

# CATEGORIES
# These are NEW categories, not in Drupal. Add as many sets as needed.
INSERT IGNORE INTO wordpress.wp_terms (name, slug)
	VALUES
	('First Category', 'first-category'),
	('Second Category', 'second-category'),
	('Third Category', 'third-category')
;

# Set category names to title case (in case term already exists [as a tag] in lowercase).
UPDATE wordpress.wp_terms SET name = 'First Category' WHERE name = 'first category';
UPDATE wordpress.wp_terms SET name = 'Second Category' WHERE name = 'second category';
UPDATE wordpress.wp_terms SET name = 'Third Category' WHERE name = 'third category';

# Add categories to taxonomy.
INSERT INTO wordpress.wp_term_taxonomy (term_id, taxonomy)
	VALUES
	((SELECT term_id FROM wp_terms WHERE slug = 'first-category'), 'category'),
	((SELECT term_id FROM wp_terms WHERE slug = 'second-category'), 'category'),
	((SELECT term_id FROM wp_terms WHERE slug = 'third-category'), 'category')
;

# Auto-assign posts to category.
# You'll need to work out your own logic to determine strings/terms to match.
# Repeat this block as needed for each category you're creating.
INSERT IGNORE INTO wordpress.wp_term_relationships (object_id, term_taxonomy_id)
	SELECT DISTINCT p.ID AS object_id,
		(SELECT tt.term_taxonomy_id
		FROM wordpress.wp_term_taxonomy tt
		INNER JOIN wordpress.wp_terms t USING (term_id)
		WHERE t.slug = 'enter-category-slug-here'
		AND tt.taxonomy = 'category') AS term_taxonomy_id
	FROM wordpress.wp_posts p
	WHERE p.post_content LIKE '%enter string to match here%'
	OR p.ID IN (
		SELECT tr.object_id
		FROM wordpress.wp_term_taxonomy tt
		INNER JOIN wordpress.wp_terms t USING (term_id)
		INNER JOIN wordpress.wp_term_relationships tr USING (term_taxonomy_id)
		WHERE t.slug IN ('enter','terms','to','match','here')
		AND tt.taxonomy = 'post_tag'
	)
;

# Update category counts.
UPDATE wp_term_taxonomy tt
	SET `count` = (
		SELECT COUNT(tr.object_id)
		FROM wp_term_relationships tr
		WHERE tr.term_taxonomy_id = tt.term_taxonomy_id
	)
;

# AUTHORS
INSERT IGNORE INTO wordpress.wp_users
	(ID, user_login, user_pass, user_nicename, user_email,
	user_registered, user_activation_key, user_status, display_name)
	SELECT DISTINCT
		u.uid, u.mail, NULL, u.name, u.mail,
		FROM_UNIXTIME(created), '', 0, u.name
	FROM drupal.users u
	INNER JOIN drupal.users_roles r
		USING (uid)
	WHERE (1
		# Uncomment and enter any email addresses you want to exclude below.
		# AND u.mail NOT IN ('test@example.com')
	)
;

# Assign author permissions.
# Sets all authors to "author" by default; next section can selectively promote individual authors
INSERT IGNORE INTO wordpress.wp_usermeta (user_id, meta_key, meta_value)
	SELECT DISTINCT
		u.uid, 'wp_capabilities', 'a:1:{s:6:"author";s:1:"1";}'
	FROM drupal.users u
	INNER JOIN drupal.users_roles r
		USING (uid)
	WHERE (1
		# Uncomment and enter any email addresses you want to exclude below.
		# AND u.mail NOT IN ('test@example.com')
	)
;
INSERT IGNORE INTO wordpress.wp_usermeta (user_id, meta_key, meta_value)
	SELECT DISTINCT
		u.uid, 'wp_user_level', '2'
	FROM drupal.users u
	INNER JOIN drupal.users_roles r
		USING (uid)
	WHERE (1
		# Uncomment and enter any email addresses you want to exclude below.
		# AND u.mail NOT IN ('test@example.com')
	)
;

# Change permissions for admins.
# Add any specific user IDs to IN list to make them administrators.
# User ID values are carried over from Drupal.
UPDATE wordpress.wp_usermeta
	SET meta_value = 'a:1:{s:13:"administrator";s:1:"1";}'
	WHERE user_id IN (1) AND meta_key = 'wp_capabilities'
;
UPDATE wordpress.wp_usermeta
	SET meta_value = '10'
	WHERE user_id IN (1) AND meta_key = 'wp_user_level'
;

# Reassign post authorship.
UPDATE wordpress.wp_posts
	SET post_author = NULL
	WHERE post_author NOT IN (SELECT DISTINCT ID FROM wordpress.wp_users)
;

# VIDEO - READ BELOW AND COMMENT OUT IF NOT APPLICABLE TO YOUR SITE
# If your Drupal site uses the content_field_video table to store links to YouTube videos,
# this query will insert the video URLs at the end of all relevant posts.
# WordPress will automatically convert the video URLs to YouTube embed code.
UPDATE IGNORE wordpress.wp_posts p, drupal.content_field_video v
	SET p.post_content = CONCAT_WS('\n',post_content,v.field_video_embed)
	WHERE p.ID = v.nid
;

# IMAGES - READ BELOW AND COMMENT OUT IF NOT APPLICABLE TO YOUR SITE
# If your Drupal site uses the content_field_image table to store images associated with posts,
# but not actually referenced in the content of the posts themselves, this query
# will insert the images at the top of the post.
# HTML/CSS NOTE: The code applies a "drupal_image" class to the image and places it inside a <div>
# with the "drupal_image_wrapper" class. Add CSS to your WordPress theme as appropriate to
# handle styling of these elements. The <img> tag as written assumes you'll be copying the
# Drupal "files" directory into the root level of WordPress, NOT placing it inside the
# "wp-content/uploads" directory. It also relies on a properly formatted <base href="" /> tag.
# Make changes as necessary before running this script!
UPDATE IGNORE wordpress.wp_posts p, drupal.content_field_image i, drupal.files f
	SET p.post_content =
		CONCAT(
			CONCAT(
				'<div class="drupal_image_wrapper"><img src="files/',
				f.filename,
				'" class="drupal_image" /></div>'
			),
			p.post_content
		)
	WHERE p.ID = i.nid
	AND i.field_image_fid = f.fid
	AND (
		f.filename LIKE '%.jpg'
		OR f.filename LIKE '%.jpeg'
		OR f.filename LIKE '%.png'
		OR f.filename LIKE '%.gif'
	)
;

# Fix post_name to remove paths.
# If applicable; Drupal allows paths (i.e. slashes) in the dst field, but this breaks
# WordPress URLs. If you have mod_rewrite turned on, stripping out the portion before
# the final slash will allow old site links to work properly, even if the path before
# the slash is different!
UPDATE wordpress.wp_posts
	SET post_name =
	REVERSE(SUBSTRING(REVERSE(post_name),1,LOCATE('/',REVERSE(post_name))-1))
;

# Miscellaneous clean-up.
# There may be some extraneous blank spaces in your Drupal posts; use these queries
# or other similar ones to strip out the undesirable tags.
UPDATE wordpress.wp_posts
	SET post_content = REPLACE(post_content,'<p>&nbsp;</p>','')
;
UPDATE wordpress.wp_posts
	SET post_content = REPLACE(post_content,'<p class="italic">&nbsp;</p>','')
;

# NEW PAGES - READ BELOW AND COMMENT OUT IF NOT APPLICABLE TO YOUR SITE
# MUST COME LAST IN THE SCRIPT AFTER ALL OTHER QUERIES!
# If your site will contain new pages, you can set up the basic structure for them here.
# Once the import is complete, go into the WordPress admin and copy content from the Drupal
# pages (which are set to "pending" in a query above) into the appropriate new pages.
INSERT INTO wordpress.wp_posts
	(`post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`,
	`post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`,
	`post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`,
	`post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`,
	`post_mime_type`, `comment_count`)
	VALUES
	(1, NOW(), NOW(), 'Page content goes here, or leave this value empty.', 'Page Title',
	'', 'publish', 'closed', 'closed', '',
	'slug-goes-here', '', '', NOW(), NOW(),
	'', 0, 'http://full.url.to.page.goes.here', 1, 'page', '', 0)
;
