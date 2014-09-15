## Project Management Notes ##

Taken from: Expert PHP and MySQL (http://www.apress.com/9781430260073)

People determine success; the success of your application is determined by
whether or not people are satisified with it.
- Who are these people?
  - Need to ask to find out who you are trying to satisfy with the software
  - Hint: it may not be the people who pay you, or originally define the scope
    of the project, you may need to dig to find these people
- How to satisfy them?
  - The "how" becomes the project's "requirements"
- You have to identify real customers, and you have to identify real product
  - Once you identify the customers and the product, your job is to build and
  deliver it

Software projects have three dimensions:
- _Requirements_: What the system will do
- _People_: The development team that will build the project
- _Schedule_: How long it will take the project to build

General notes about project requirements
- Requirements should only be adjusted by adding or dropping functionality,
  never by adjusting quality.
  - Only the highest quality is acceptable, always
  - Far, far better to have an important function missing than to have it work
    unreliably

Hiring
- _Hiring the Best_, by Martin Yate
- If your company is in trouble, your technology and product are old, your
  salaries aren't competitive, your location is lousy, or the project sounds
  dreary, you're not going to get good people to work for you
  - Maybe you shouldn't even be there yourself

Schedule
- A schedule's purposes are:
  - To force a careful look at all of the requirements, and
  - To force the team to come up with at least one plausable scenario that
    leads to success, and
  - To keep development operating at a steady pace, and
  - To place a bound on how elaborately a component should be developed
- You always schedule based on the requirements you do have, but you qualify a
  schedule based on loosely defined requirements are being subject to change
  - As the requirements get more specific, refine the schedule
  - The project's scope should always be delineated, so it's clear how much of
    the problem the application is supposed to address, and just as important,
    what the application won't address
- To estimate development time, pick one or two programmers with the most
  experience related to the project at hand, and ask them how long it would
  take them to do each item in the requirements
  - Estimates can be in half-days, assuming each half-day is four hours
  - Make sure every task is included: documentation, training development,
    testing, localization, and everything else that's needed for a complete
    product

Tasks
- Tasks should be tagged as being one of three types, depending on how
  accurately they can be estimated
  - _Type 1 tasks_ are similar to something that's been done before, so their
    implementation time can be fairly accurately predicted
  - _Type 2 tasks_ are new, but it's well understood how to do them
  - _Type 3 tasks_ are those for which the requirements are vague or the
    implementation approach is unknown, and estimates for them are wild
    guesses

Calculating project length
- Apply a productivity factor to the estimates, between 2x and 4x
- Figure out how many actual working hours there are available
  - If there are technical support and other non-project duties, it might only
    be four hours
  - If it's a new project, figure six hours
  - Seven or more hours is probably too optimistic
  - Assume only 40 hour work-weeks
- All _Type 2 tasks_ (above) get their time estimates multiplied by factor of
  **1.5x**, because the estimates were rough
- All of the _Type 3 tasks_ get their time estimates multiplied by a factor of
  **3x**
- Total the scheduled task, multiplied by any difficulty factor, and that
  becomes the number of days your project will take
- Figure there are about 46 working weeks in a year
  - 52 minus vacations, holidays, and illness
- Example _Type 1_ task:
  - 1.5 half days estimate for the task, 2x average productivity factor
    (estimate is now 3 half days), and 1x risk factor
    - 3 half days total
- Example _Type 2_ task:
  - 3 half days estimate for the task, 2x average productivity factor
    (estimate becomes 6 half days), and 1.5x risk factor
    - 9 half days total
- Example _Type 3_ task:
  - 6 half days estimate for the task, 2x average productivity factor
    (eѕtimate becomes 12 half days), and 3x risk factor
    - 36 half days total

Project phases and implementation schedule
- Split any project into two phases
  - A prototyping phase, in which _Type 3_ tasks are reduced to _Type 2_
    tasks, but not actually implemented other than as a prototype
    - You don't know what resources will be required for _Type 3_ tasks, you
      don't know what impact their design will have on the rest of the system
    - Such large disturbances should come as early as possible
  - An implementation phase, where all _Type 1_ and _Type 2_ tasks are
    implemented
- Announce that the project implementation schedule will be created only after
  the prototype phase
  - This way, you're not in a position of quoting a delivery date based on
    wild guesses and then having to revise it later
- If you find yourself working in an organization that expects schedules to be
  unshakeable commitments and blames developers if they're not, make sure you
  keep track of all the changes to requirements that will occur throughout the
  project
  - That way, you can connect each schedule change to the requirement
  change that caused it

Project design
- Design is the process of taking requirements and coming up with a blueprint
  for implementing them, somewhat like the role of architecture in
  constructing a building
  - If the design is bad, the project will fail even if the requirements are
    right and the implementation of that design is perfect

Project components
- Database design and implementation
- CRUD (create, retrieve, update, delete) web pages
- Business logic/processing
- Reports and other outputs
- External interfaces - connections to other components or systems
- Internationalization
- Accessibility - making the application useable by people with disabilities
- User administration
- Billing users
- Supported platforms - client browsers, client API access, internal API
  access, what platform the project will run on
- Installation - support for installing the application
- Capacity - how many users will be able to use the application
- Conversion
- System testing
- Documentation
- Training
- Use cases - detailed descriptions of interactions between an actor and the
  application that results in something of value
  - Use cases are little stories, with characters and a plot, so they're much
    more understandable by people for whom the application is being built

Issue tracking
- As a project progresses, the team will have to keep track of changes to
  requirements, bugs found in testing, design questions to be resolved,
  assorted things to-do, and the like
  - They're called "issues", and enter them into a database so they won't be
    forgotten

Invoicing
- How much you'll be paid
- How often you'll invoice the client
- When the client will pay the invoice
- Who exactly gets the invoice
- What special codes you need to reference on the invoice, such as project
  number or supplier number

Requirements changes
- All requests for changing the project requirements should be logged
  - Ensures proposed changes isn't misplaced or ignored
  - Can be used for creating schedules or agendas for project status meetings
  - Documents the change in case anyone in the future wants to know why the
    project's schedule slipped
- A big mistake is to define so many fields in the issue tracker that it
  becomes a burden to log everything
  - Your job is to implement the application, not win an award for documenting
    how you did it

Agile Methodology
- Dividing the project into very short (like a week) fixed-length increment
  with a deliverable system at the end of each increment
- Establishing requirements only for each increment, thus allowing arbitrary
  changes throughout the project
- Continual communication with a representative of the customer who, ideally,
  is on the development team
- Daily communication among the members of the development team
- Continous unit testing and integration

vim: filetype=markdown shiftwidth=2 tabstop=2
