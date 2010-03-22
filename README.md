Whoa
====

  http://github.com/richmolj/whoa

Description
-----------

  Simple Active-Recordy API to the Google Website Optimizer (WO) API. Create experiments, start/stop/modify/search them, add/modify pages, get code snippets, etc.
  
  No Rails required.

Basic Usage
===========

Authentication
--------------
  
    > Whoa.email = 'xxxxx'
    > Whoa.password = 'xxxxx'
    
    Uses ClientLogin. OAuth coming soon.
    
Basic actions
-------------
  
  Just think Active Record. 
  
    Create

    > Whoa::Experiment.create(:title => "My New Experiment")
    
    or
    
    > Whoa::Experiment.new
    > Whoa::Experiment.title = "My New Experiment"
    > Whoa::Experiment.save
    
    Update
    
    > Whoa::Experiment.update_attributes(:title => "My new title") 
    
    Read
    
    > Whoa::Experiment.all(:status => "Running")
    > Whoa::Experiment.first(:title => "Foo")
    > Whoa::Experiment.find(123456)
    
  If you're wondering what you can get/set, take a look at the WO API docs. You also have the handy #attributes method.
  
   Delete:

   > Whoa::Experiment.first.destroy
   
   Experiments and Pages get a nice #to_xml method as well, though it won't include all attributes (see TODO)
   
Experiments
-----------

Some handy shortcuts:

  > @experiment.copy!
  > @experiment.start!
  > @experiment.stop!
  
Each experiment has #tracking\_script, #control\_script and #conversion_script. You'll need to inject this code into your pages somehow to get experiments working. 

Note that unlike the manual WO setup, the API doesn't validate your live site for tracking code. This is actually pretty handy, since you can inject code and start experiments independent of each other depending on your workflow.
   
Pages
-----

  Experiments have many pages; each page belongs to an experiment.
  
  > @experiment.pages.first
  > @experiment.create_page(:title => "foo", :content => "bar") 
  
Requirements
------------
  
  * rest-client 0.4.2
  * happymapper >= 0.3.0
  * active_support >= 2.2.0
  
TODO
----

  * OAuth
  * Right now, this only works for A/B experiments, not multivariate
  * Validations could be better handled
  * Defining what you can get/set is a bit murky.
  * Some additional API corner cases and AR-like sugar 
  * Testing. It's open-source, I slacked.
  * Haven't bothered with trying other versions of dependencies. I'm almost positive you'd get away with an older verison of ActiveSupport.
  
License
-------

  Copyright (c) 2009 richmolj@gmail.com

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  "Software"), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.        

                                                              