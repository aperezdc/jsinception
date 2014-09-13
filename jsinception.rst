:title: JS: Inception
:css: jsinception.css

----

:class: pre-title

.. raw:: html

  <div class="jslogo"><div class="jstext">JS</div></div>
  <div class="jslogo-right">Inception<br/>
    <div>JSConf EU 2014</div>
  </div>

.. note::

  Welcome everybody, it is always a pleasure to travel to Berlin, more if it
  is for attending JSConf EU — gotta love such a vibrant community. This
  is my second year attending, and this time it is not just a pleasure, but
  also a great honour to be in this side of the room, as a speaker.

  First of all, let me tell you that I have not yet watched Inception, the
  movie. Any possible references to the movie are plain coincidences —
  I just linked how the “JS: Inception” moniker sounds.

----

:data-y: r220
:class: title

.. raw:: html

  <div class="jslogo bigger">
    <div class="jslogo"><div class="jstext">JS</div></div>
    <div class="jstext">JS</div>
    <div class="js-in">in</div>
  </div>

.. note::

  Truth is, I have been wanting to use this “JS-in-JS” logo logo for a
  while, and I could not think of any other title that would fit better.

  By the way, after attending CSSConf yesterday, which was lovely, I felt
  the need to go back to the hotel and redo it using only ``<div>``\s and
  CSS.

  But before we go into details…

----

:data-x: r0
:data-y: r-900

.. raw:: html

  <div id="avatar">
    <a href="http://twitter.com/aperezdc/">@aperezdc</a>
  </div>
  <div id="finland">
  </div>
  <div id="igalia-logo"></div>
  <div id="bloomberg-logo"></div>
  <div id="logos-plus">+</div>
  <div id="v8-logo"></div>

.. note::

  …let me introduce myself.

  My name is Adrián, I am originally from Spain but currently I live in
  Helsinki, and I *actually* do enjoy the snowy winters. But if there is
  something I like is working on Free Software and getting into trouble.

  The first got me into Igalia, six years ago, where I work at the
  compilers team. The second got me into virtual machines.

  We are collaborating with Bloomberg on two fronts:
  
  1. Bringing EcmaScript 6 features to JavaScript engines.
  2. Bringing modern layout support to web engines, like CSS Grid Layout.
       
  During Rachel Andrew's talk about Grid Layout during CSSConf, I was
  checking the reactions on Twitter, and it was amazing to see so many
  positive comments. You can already use Grid now, and it would not have
  been possible without Bloomberg's sponsoring.

----

:data-x: r-900
:data-rotate-z: 40

Agenda
======

.. code:: javascript

  var i = new Inception();
  var knowledge = i.learn();

  while (i.secondsElapsed < 20 * 60) {
    knowledge.liveCoding();
    knowledge.refine(i);
  }


.. note::

  So, what's in for today?

  1. I will explain what the “Inception” thing is about, then
  2. the main part of the talk will actually be implementing,
     a small feature from the EcmaScript 6 specification into
     V8. And this is going to happen live, on stage.

----

:data-x: r-50
:data-y: r450

Not Happening
=============

.. raw:: html

  <div id="ex-parrot">
    <div>“This is an ex-parrot!”</div>
  </div>

* Transpiling (e.g. Traceur).
* Implementing a JavaScript engine.

.. note::

  To make things clear, let me first tell you what this is **not** about:

  * How many people here knows about Traceur, or what a transpiler is?
    Well I will **not** be talking about that today.
  * Also, I will **not** be talking about implementing a JavaScript engine.


----

:data-y: r350

.. class:: reveal centerbox

Implementing **features** of existing JavaScript engines **using
JavaScript**.

.. note::

  Once the language is implemented, there is nothing that prevents to use
  JavaScript itself from being useful to implement parts of the language
  specification. The same as the standard C/C++ library is written in C/C++,
  and built.

  There are a number of reasons to do this, some of them are quite clear:

  * JavaScript is more expressive than C++.
  * Faster development: compile-test-debug cycles are shorter.
  * Just *because*.

  But there are also some not-so-obvious reasons to do this:

  * Modern JIT compilers can generate code as good as our hand made C/C++.
    - Sometimes even faster: no calls into the C/C++ runtime.
  * Fame and glory! (Become an engines hacker yourselves).
  * Just *because*.

----

:data-x: r50
:data-y: r550
:data-rotate-z: 20
:data-scale: 0.75

kLOC [#]_
=========

.. class:: align-data-right legend-first-column

============== ===== == ===
Engine         Total JS %
============== ===== == ===
JavaScriptCore   269  1 0.3
SpiderMonkey     457 18 3.9
V8               532 23 4.3
============== ===== == ===

.. [#] Measured with `CLOC <http://cloc.sf.net>`__, excluding test
       suites, benchmarks and other tools.

.. note::

  To give an idea of how much major engines are using JavaScript, this is
  the current ranking as of yesterday. JavaScriptCore is the one using less
  JavaScript: only about a thousand lines. Up next are SpiderMonkey with
  eighteen thousand lines, and V8 with twenty-three thousand lines.

  The line counts are code excluding everything that is not part of the
  implementation: test suites, helper tools and so are not adding up to
  these numbers.

----

:data-rotate-z: 0
:data-y: r450

What's missing of ES6?
======================

.. class:: center

(in V8)

.. note::

  Most of the runtime features that are good to be implemented using
  JavaScript are already in V8. Even most of the EcmaScript 6 ones.

  There methods missing in typed arrays which are good candidatates.

----

:data-y: r600


``Int{x}Array.forEach()``
=========================

.. code:: javascript

  Int8Array.prototype.forEach = function (cb) {
    for (var i = 0; i < this.length; i++)
      cb(this[i]);
  };


.. note::

  * Simple version, as in polyfill.
  * It actually does work.

----

:data-y: r350
:data-x: r0

.. code:: javascript

  Int8Array.prototype.forEach = function (cb, thisArg) {
    if (thisArg === undefined)
      thisArg = this;
    for (var i = 0; i < this.length; i++)
      cb.call(thisArg, this[i]);
  };


.. note::

  * Introduces ``thisArg``.
  * Handles ``thisArg`` being not passed (undedefined).

----

:data-y: r450

.. code:: javascript

  function GenericForEach(cb, thisArg) {
    if (thisArg === undefined)
      thisArg = this;
    for (var i = 0; i < this.length; i++)
      cb.call(thisArg, this[i]);
  }

  Int8Array.prototype.forEach = GenericForEach;
  Int16Array.prototype.forEach = GenericForEach;
  // …

----

:data-y: r475

.. code:: javascript

  function Int8ArrayForEach(cb, thisArg) { /* … */ }
  Int8Array.prototype.forEach = Int8ArrayForEach;

  function Int16ArrayForEach(cb, thisArg) { /* … */ }
  Int16Array.prototype.forEach = Int16ArrayForEach;

  // …


.. note::

  * Inferred types are always the same:

    - Better for the JIT.
    - No need to bail out from generated code.

  * V8 has a macro expansion mechanism used to generate variants of the same
    function. It is used for the typed arrays impleentation.


----

:data-rotate-y: 90

.. raw:: html

  <div class="demotime beatles">
    <div>Showtime!</div>
    <audio src="livecoding.mp3" controls>
  </div>

----

:data-rotate-y: 0


``d8 --allow-natives-syntax``

----

Takeaways
=========

* JavaScript is great to start hacking on engines.

* All major engines use it — more or less.

* The complexity of the spec **will** hit you.

* Hacking on engines is rewarding, **start now**!

----

:data-x: 0
:data-y: -2400

Other credits
=============

Music
  AC Customusic (Hopefully Public Domain)

Pixel Art
  `Héctor Bometón <http://www.mierdecitas.com>`__

----

:data-x: 0
:data-y: 0
:data-scale: 4
:data-rotate-y: 0

.. :data-scale: 0.025
