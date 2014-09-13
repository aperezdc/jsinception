:title: JS: Inception
:css: jsinception.css

----

:class: noborder pre-title

.. raw:: html

  <div class="jslogo bigger">
    <div class="jslogo"><div class="jstext">JS</div></div>
    <div class="jstext">JS</div>
    <div class="js-in">in</div>
  </div>

----

:data-y: r-220
:class: noborder title

.. raw:: html

  <div class="jslogo"><div class="jstext">JS</div></div>
  <div class="jslogo-right">Inception<br/>
    <div>JSConf EU 2014</div>
  </div>

----

:data-x: r0
:data-y: r-800

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
  <!--
  <div class="jslogo-right">
    <a href="mailto:aperez@igalia.com">aperez@igalia.com</a>
    <a href="http://perezdecastro.org">perezdecastro.org</a>
    <a href="https://twitter.com/aperezdc">@aperezdc</a>
  </div>
  -->

----

:data-x: r-900
:data-rotate: 40

What this is *not* about
========================

* Transpiling (e.g. Traceur).
* Implementing a JavaScript engine.

----

:data-x: r30
:data-y: r500

So, then?
=========

.. class:: reveal centerbox

Implementing features of a JavaScript engine **using JavaScript**.

----

:data-x: r-1100
:data-y: r-400
:data-rotate: 0
:data-scale: 2

Rationale
=========

In comparison with C/C++, JavaScript provides:

* More expressiveness.
* Faster development.
* Fame and glory!

.. note::

   * Faster build times
   * Simpler

----

:data-x: 1100
:data-y: -400
:data-scale: 1

kLOC [#]_
=========

.. class:: align-data-right legend-first-column

============= ===== == ===
Engine        Total JS %
============= ===== == ===
SpiderMonkey    457 18 3.9
JSC             269  1 0.3
V8              532 23 4.3
============= ===== == ===

.. [#] Measured with `CLOC <http://cloc.sf.net>`__, excluding test
       suites, benchmarks and other tools.

----

:data-y: r800

Implementing ``forEach()``
==========================

.. code:: javascript

  Int8Array.prototype.forEach = function (cb) {
    for (var i = 0; i < this.length; i++)
      cb(this[i]);
  };


.. note::

  * Simple version, as in polyfill.
  * It actually does work.

----

:data-y: r400
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
:data-x: r0

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

  <div class="demotime">
    <div>It's demo time!</div>
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
