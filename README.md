# Design Drill: Classical Inheritance 

## Summary

  We've begun building a new game.  We're modeling the game's characters on differnt team mascots:  nighthawks, otters, etc.  Players will select a mascot, which they will train by battling other mascots.  Through the battles, mascots earn experience points and grow more powerful.  So, basically, it's like Pokemon.

### More on the Mascots

We've begun our game by focusing on the mascots themselves.  We've written classes to represent individual mascot species (e.g., `Nighthawk`).  An instance of one of our mascots has specific stats which are similar to a Pokemon's stats. (e.g., hit points, experience points, etc.) and also behaviors (e.g., its moves). 

The individual mascots each have a type as well.  For example, otters and sea lions are both water-type mascots, while nighthawks are flying-type mascots.  Mascots of the same type share some characteristics, like moves or resistance to certain types of attacks.


### The Pain of Change
We've only begun to design our mascots, but already we're feeling some pain.  For example, we have a formula for calculating a mascot's attack strength based on its base attack strength, its level, etc.  Any time we want to tweak the formula, we have to change it in each mascot class!  We only have six so far.  Imagine what it'll be like when we have 50.

It feels like there might be a better way of organizing our code. In the following exercises, we will do just that.


##########
Part 1
##########

  ## Get to Know the Mascots
    We know that we have knowledge repeated throughout our codebase. Let's review the code that we have (i.e., the mascot classes and their tests).  What knowledge is duplicated?  Where is it duplicated?

  ## Goal of Part 1: 
    Read over the code and familiarize yourself with each class and method.


##########
Part 2
##########

  ## Model the System Using Inheritance
    We have an opportunity to apply inheritance to our code base. Since many of our objects are of the same type, we might use inheritance to ensure their shared behaviors are defined in one place.  We should try to implement the hierarchical structure as described in the readme-assets directory (see the figure provided there). We have tests, which show that our code is working as we want it to.  As we refactor, we want to ensure that our tests continue to pass.

  *Note* 
    We should be familiar with aspects of inheritance in Ruby (e.g., method lookup).  We'll also need to account for how inheritance affects the visibility of constants.

  ## Goal of part 2: 
    Refactor the code provided to you (i.e. keep the same functionality but change how the code is organized). Follow the diagram provided in readme-assets to guide how you name your classes and their relationship to each other. Create new classes and set up inheritance relationships. Don't forget to put require_relative if a class needs to be able to see another class (for example, a subclass would need to be able to see its parent class).


##########
Part 3
##########

  ## Bug-type Mascots
    Now that our code is in a more maintainable state, let's continue to develop our game.  Add some bug-type mascots: dragonflies and fireflies.  Specifications for each mascot are provided in Table 1. We'll need to write tests to demonstrate that each mascot behaves as expected.

    |                       | Dragonfly    | Firefly     |
    | :-------------------- | :----------- | :---------- |
    | Base Hit Points       | 60           | 60          |
    | Base Attack Strength  | 55           | 45          |
    | Base Defense Strength | 50           | 50          |
    | Resistance            | Flying       | Flying      |
    | Susceptibility        | Water        | Water       |
    | Immunity              | Ground       | Ground      |
    | Attack 1              | Bug Bite     | Bug Bite    |
    | Attack 2              | Buzz         | Buzz        |
    | Attack 3              | Silver Wind  | Signal Beam |
    | Attack 4              | Pin Missile  | Scissor     |

    *Table 1*. Details for bug-type mascots.

  ## Goal of Part 3:
    Create three new classes: BugType (the parent class), Dragonfly, and Firefly.
    Model these classes based on the description above. Create rspec tests for each of these classes in the spec directory (imitate how tests were written for the other classes.)


##########
Part 4
##########

  ## Introduce Status and Status-changing Behaviors
    We now have a nice collection of mascots, but we're noticing that their abilities aren't balanced.  We're going to try to add more balance by introducing status.  All mascots should now have a status, which defaults to :normal. Some mascots will have additional behaviors that allow them to change their status.  For example, a mascot could be levitating, raging, etc. Each status would affect gameplay in some way.

    These status-changing behaviors will not follow the same hierarchy with which we've been working. In other words, within a given mascot type, not all the mascots share the same status-changing behavior. At the same time, the same status-changing behavior can be found in mascots of different types.  To sum it up, the type of inheritance we've been using so far won't work for this situation.

    We need to employ another technique for sharing behavior. We need to create a module for each of the status-changing behaviors (e.g., `Levitating`) and include it in each of the mascot classes we want to have that behavior (see Table 2).  

      Below is a table describing which mascots should include which module.

      | Mascot      | Levitating | Raging |
      | :---------- | :--------: | :----: |
      | Bison       |            |        |
      | Bobolink    |            | X      |
      | Dragonfly   |            |        |
      | Firefly     |            |        |
      | Nighthawk   |            | X      |
      | Otter       | X          | X      |
      | Sea Lion    |            |        |
      | Squirrel    | X          |        |

      *Table 2*. Which mascots have which status-changing behaviors.

  ## Goal of Part 4: 
    Create a new attribute in the Mascot class called status that defaults to :normal. Write a getter method for this attribute. Then write two modules: Levitating and Raging. Include those modules in the appropriate classes. These modules change the value of @status for that instance. The modules should contain two methods each:

  Raging module:
    Instance methods:
      rage: Changes @status to :rage
      reset_status: Changes @status to :normal

  Levitating module:
    Instance methods:
      Levitate: Changes @status to :Levitate
      reset_status: Changes @status to :normal

  Also, add additional tests to the appropriate spec files that demonstrate:
    (1) that all mascots initialize with a normal status.
        - If you call the instance method 'status' on a mascot, it should 
          initially return :normal
    (2) That levitating/raging mascots can change their status.
        - If you call the instance method 'rage' on a mascot that includes the 
          Raging module, then check its status, it should be changed to :rage.
        - If you call the instance method 'levitat' on a mascot that includes 
          the Levitating module, then check its status, it should be changed to :levitate.
    (3) That a status can be returned to normal.
        - If you call the instance method reset_status on a mascot then check
          its status, it should return :normal

    Below is an example of the code we should be able to write once we write the modules described above:

    otter = Otter.new
    # => #<Otter:0x007feed3b1f2a0 @status=:normal, @experience=0, @health=10>
    otter.status
    # => :normal

    otter.rage
    otter.status
    # => :raging

    otter.reset_status
    otter.status
    # => :normal



## Conclusion
Whether through subclassing (e.g., mascot --> water-type --> otter) or mixing in modules, inheritance is one technique that we can use to model a system and organize our code.  Of course, when using such a technique, we need to understand how it works.  Can we explain the basics of how method look up works in Ruby?  How is it affected by one class inheriting from another class?  How is it affected by including a module in a class?

########################################################
# Compress your directory and turn it in on Schoology. #
########################################################




