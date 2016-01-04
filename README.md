# Pivotal-Hub
Pivotal-Hub is a helper to lazy developers that is tired of start manually their stories in Pivotal Tracker and some tasks in Git.

It was created in order to automate basic tasks in Pivotal Tracker and Git.

#What do i get to use it?

* Assertiveness in your process of starting a story
* Agility in daily tasks
* More time to think in _**cool stufs.**_ :D

#Installation

`gem install pivotal_hub`

#Configuration

For Pivotal-Hub run its necessary for you add three parameters in your git config, who are they:

Name | Description
------------ | -------------
pivotal.api-token | This parameter it's your Pivotal token, he will say who you are and identifies all your actions.
pivotal.project-id | This parameter it's your Pivotal project you are working.
pivotal.sprint-label | This parameter it's the label that is on stories that his team is currently working.
 
You can set these parameters through the command git config --global, example:

`git config --global pivotal.api-token "MY_TOKEN"`

#Dependencies

`gem install tracker_api`
`gem install git`

#How to use?

Enter the directory of your project through the terminal or prompt command, and type `pivotal-start`.

Pivotal-Hub identifies in which branch you are currently, if you are in a branch that does not begin with numbers, interprets that
you have not started a story and will offer to you the stories in your backlog with the label setting in pivotal.sprint-label. (limited to 10)

But if the actual branch starts with numbers, Pivotal-Hub interprets that you are working in a story and only starts it in Pivotal Tracker. according to the name of the branch.

Example: 123456789_MyBranch

Pivotal-Hub will get the numbers before underline (123456789) and will starts corresponding to that value.
