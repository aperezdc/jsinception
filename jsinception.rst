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
    <a href="mailto:aperez@igalia.com">aperez@igalia.com</a>
    <a href="http://perezdecastro.org">perezdecastro.org</a>
    <a href="https://twitter.com/aperezdc">@aperezdc</a>
  </div>

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

Slide +1
========

----

:data-x: 0
:data-y: 0
:data-scale: 4

.. :data-scale: 0.025
