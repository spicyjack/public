//
// Shakespearean insult generator
//
// Copyright (c) 2006-2014 Stephen Williams, all rights reserved.
// From: https://stephenw32768.appspot.com/shakespeare/shakespeare_js.txt
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
// 3. The name of the copyright holder may not be used to endorse or
//    promote products derived from this software without specific prior
//    written permission.
//
// THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
// IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
//

// $Id: shakespeare.in.js,v 2.1 2014/08/01 14:57:56 stephen Exp $

// From http://www.ljhs.sandi.net/faculty/mteachworth/strange-n-mundane/interesting-articles/shakespearean-insults.htm
var adjectives1 = [
   "artless",
   "bawdy",
   "beslubbering",
   "bootless",
   "churlish",
   "cockered",
   "clouted",
   "craven",
   "currish",
   "dankish",
   "dissembling",
   "droning",
   "errant",
   "fawning",
   "fobbing",
   "froward",
   "frothy",
   "gleeking",
   "goatish",
   "gorbellied",
   "impertinent",
   "infectious",
   "jarring",
   "loggerheaded",
   "lumpish",
   "mammering",
   "mangled",
   "mewling",
   "paunchy",
   "pribbling",
   "puking",
   "puny",
   "quailing",
   "rank",
   "reeky",
   "roguish",
   "ruttish",
   "saucy",
   "spleeny",
   "spongy",
   "surly",
   "tottering",
   "unmuzzled",
   "vain",
   "venomed",
   "villainous",
   "warped",
   "wayward",
   "weedy",
   "yeasty"
];
var adjectives2 = [
   "base-court",
   "bat-fowling",
   "beef-witted",
   "beetle-headed",
   "boil-brained",
   "clapper-clawed",
   "clay-brained",
   "common-kissing",
   "crook-pated",
   "dismal-dreaming",
   "dizzy-eyed",
   "doghearted",
   "dread-bolted",
   "earth-vexing",
   "elf-skinned",
   "fat-kidneyed",
   "fen-sucked",
   "flap-mouthed",
   "fly-bitten",
   "folly-fallen",
   "fool-born",
   "full-gorged",
   "guts-griping",
   "half-faced",
   "hasty-witted",
   "hedge-born",
   "hell-hated",
   "idle-headed",
   "ill-breeding",
   "ill-nurtured",
   "knotty-pated",
   "milk-livered",
   "motley-minded",
   "onion-eyed",
   "plume-plucked",
   "pottle-deep",
   "pox-marked",
   "reeling-ripe",
   "rough-hewn",
   "rude-growing",
   "rump-fed",
   "shard-borne",
   "sheep-biting",
   "spur-galled",
   "swag-bellied",
   "tardy-gaited",
   "tickle-brained",
   "toad-spotted",
   "unchin-snouted",
   "weather-bitten"
];
var nouns = [
   "apple-john",
   "baggage",
   "barnacle",
   "bladder",
   "boar-pig",
   "bugbear",
   "bum-bailey",
   "canker-blossom",
   "clack-dish",
   "clotpole",
   "coxcomb",
   "codpiece",
   "death-token",
   "dewberry",
   "flap-dragon",
   "flax-wench",
   "flirt-gill",
   "foot-licker",
   "fustilarian",
   "giglet",
   "gudgeon",
   "haggard",
   "harpy",
   "hedge-pig",
   "horn-beast",
   "hugger-mugger",
   "jolthead",
   "lewdster",
   "lout",
   "maggot-pie",
   "malt-worm",
   "mammet",
   "measle",
   "minnow",
   "miscreant",
   "moldwarp",
   "mumble-news",
   "nut-hook",
   "pigeon-egg",
   "pignut",
   "puttock",
   "pumpion",
   "ratsbane",
   "scut",
   "skainsmate",
   "strumpet",
   "varlot",
   "vassal",
   "whey-face",
   "wagtail"
];

var starts_with_vowel = /^[aeiou]/;
var article, adjective1, adjective2, noun;
var invocations = 0;

/** picks a random item from an array */
Array.prototype.randomItem = function()
{
   var num = Math.random();
   num *= this.length;
   num = Math.floor(num);
   return this[num];
}

/** chooses two adjectives and a noun from the data */
function pick_words()
{
   adjective1 = adjectives1.randomItem();
   adjective2 = adjectives2.randomItem();
   noun = nouns.randomItem();
   article = starts_with_vowel.test(adjective1) ? "an" : "a";
}

/** generates and displays the insult */
function generate_insult()
{
   pick_words();

   var insult = [
      "Verily, thou art ", article, " ",
      adjective1, ", ", adjective2, " ", noun, "."
   ].join('');

   if (invocations > 0) {
      var greeting = (invocations % 2) == 0
         ? "Mr William Shakespeare doth declare:"
         : "Willy Shakespeare sez:";
      document.getElementById("declare").innerHTML = greeting;
   }
   document.getElementById("insult").innerHTML = insult;
   invocations++;

   return false; // cancel form submission
}

document.getElementById("button").style.display = "initial";
document.forms[0].onsubmit = generate_insult;
generate_insult();
