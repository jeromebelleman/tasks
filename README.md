Manage your tasks in freedom with Vim, organise them by project, store them
in different git repositories on different devices and sync them effortlessly.

I've always been keen on using [Taskwarrior](http://taskwarrior.org), a
powerful, fast command line task manager. But over time, I realised that
I simply didn't use it a lot. When asking myself why, I understood that it
was because adding/editing tasks wasn't as effortless as it should be, so
it was just easier for me to not do it and try and remember what I had to do.

This wasn't a solution, obviously, so I decided to write a new task manager,
concentrating on its usability so that adding/editing tasks would become
sufficiently comfortable that I could be encouraged to do it: `tasks` was
the result, and little did I know then that it would change my life.

# NAME

tasks - Manage tasks

# SYNOPSIS

`tasks [-h] [-d DIRECTORY] [-s SHARED] {edit,projects,pull,push,import} ...`

`tasks edit [-p PROJECT] [-c]`

`tasks projects`

`tasks pull DIRECTORY`

`tasks push DIRECTORY`

`tasks import FILE`

# OPTIONS

`-h, --help`
:   Show help message and exit.

`-d DIRECTORY, --directory DIRECTORY`
:   Task directory.


`-s SHARED, --shared SHARED`
:   Shared directory, where the **vimrc** file may be found.


# EDITING TASKS

Reading, creating and editing tasks all take place with the **edit**
command, which will take you to a Vim buffer to perform all those operations.
Once the buffer is saved and closed, the changes are written to disk.

## THE VIM BUFFER

From inside Vim, you can use the **:AddTask** command to add new tasks, ready
for editing. Fields such as *Project* and *Description* are compulsory. Vim
will reopen the buffer until you fill them out.

Completion is available for most fields with **CTRL-U**:

  - In the *Project* field, it will complete from the project path
    written so far.
  - In the *Priority* field, it will offer today's date or complete from
    existing priorities, displaying a summary of the other tasks bearing this
    priority.
  - In the *Opened*, *Closed* fields and everywhere else, it will offer
    today's date.

A task is closed by giving it a *Closed* date.
Removing tasks is carried out by removing it from the Vim buffer.

## PROJECTS

Traditionally, projects and sub-project paths are separated with dots, but
the string can be whatever you like, really. Note that filtering by project
disregards the separator and will simply filter by what the query string
starts with.

## PRIORITIES

There are 2 types of priorities used, and they try to play well with each
other:

  - Numeric priorities, the higher the value, the higher the priority.
  - Due dates, which are set in the *Priority* field as well. A numeric
    priority is computed on the fly from the due date, taking the number
    of remaining days off the highest of all priorities. This requires some
    calibration, and once this is done it works rather well.

Either way, higher priorities will show first in the buffer.

## OPTIONS

`-p PROJECT, --project PROJECT`
:   Filter by PROJECT.

`-c, --closed`
:   Display and sort by closed tasks.

# VERSION CONTROL

Each and every change written to disk is committed into a git repository.
It works quite well to set up a central *bare* repository on a server
(http://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server)
where you can use **task push** and **task pull** to keep your tasks in sync
everywhere.

# INTERNAL COMMANDS

The following sub-commands are mostly used internally from the Vim buffer
and running them manually doesn't make much sense:

   - **add**
   - **priorities**
