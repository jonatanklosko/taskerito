# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#

alias Taskerito.Repo
alias Taskerito.Accounts.User
alias Taskerito.Projects.{Project, Task, Comment}

user1 =
  Repo.insert!(
    User.sign_up_changeset(%User{}, %{
      username: "jakeperalta",
      name: "Jake Peralta",
      email: "jake@peralta.me",
      password: "password"
    })
  )

user2 =
  Repo.insert!(
    User.sign_up_changeset(%User{}, %{
      username: "tcrews",
      name: "Terry Crews",
      email: "terry@crews.me",
      password: "password"
    })
  )

user3 =
  Repo.insert!(
    User.sign_up_changeset(%User{}, %{
      username: "rayholt",
      name: "Raymond Holt",
      email: "ray@holt.me",
      password: "password"
    })
  )

Repo.insert!(%Project{
  name: "Family party",
  description: "Everything related to the huge family meeting 2020.",
  author: user1,
  tasks: [
    %Task{
      name: "Buy gifts",
      description:
        "This is a tricky business. We need to figure out proper gifts for every family member.",
      priority: 3,
      author: user1,
      comments: [
        %Comment{
          content: "This sounds fun and creative, I'm gonna take this on!",
          author: user2
        }
      ]
    },
    %Task{
      name: "Prepare menu",
      description:
        "With a huge family like that, there are many people with dietary restrictions. Someone should contact the relevant family members and prepare a list. Then we can draft a menu proposal.",
      priority: 2,
      author: user1,
      comments: [
        %Comment{
          content:
            "I've got a partial list from last year, although some folks surely switched to vegetarian diet.",
          author: user3
        },
        %Comment{
          content: "Alright, assigning it to you in this case!",
          author: user1
        }
      ],
      assignees: [user3]
    },
    %Task{
      name: "Send invitations",
      description:
        "All the addresses are stored in our family database. The invitation cards have already been prepared, we just need to make sure they make it on time.",
      priority: 1,
      author: user1,
      finished_at: DateTime.truncate(DateTime.utc_now(), :second),
      assignees: [user1]
    },
    %Task{
      name: "Choose movies",
      description:
        "Traditionally we're gonna watch a bunch of movies together, so we need to brain storm a long list. Keep in mind that most of the movies should be suitable to the teengares.",
      priority: 4,
      author: user1,
      comments: [
        %Comment{
          content: "Brooklyn 99 is a must have, no doubt!",
          author: user2
        },
        %Comment{
          content: "And so is Die Hard, no way I give it up =)",
          author: user1
        },
        %Comment{
          content:
            "That sure does sound appealing, although I think we should admire some documentaries this year.",
          author: user3
        }
      ],
      assignees: [user2, user3]
    }
  ]
})

Repo.insert!(%Project{
  name: "Mars 2020",
  description: "An open initiative of building rockets and sending people to Mars.",
  author: user3,
  tasks: [
    %Task{
      name: "Advertise",
      description:
        "We need a great media coverage and a bunch of interviews. The world needs to get to know about all the cool stuff we're doing.",
      priority: 2,
      author: user3,
      comments: [
        %Comment{
          content: "I have experience in this domain, happy to take this on.",
          author: user2
        }
      ],
      assignees: [user2]
    },
    %Task{
      name: "Get funds",
      description:
        "We're looking for numerous sponsors. Our main targets are tech companies that can provide us with necessary materials, tools and expertise.",
      priority: 1,
      author: user3,
      comments: [
        %Comment{
          content: "Gonna talk to Google and Amazon.",
          author: user1
        },
        %Comment{
          content: "I believe SpaceX would be happy to join.",
          author: user3
        }
      ],
      assignees: []
    },
    %Task{
      name: "Design a fancy logo",
      description:
        "The key to success is a lovely logo that stays in one's mind after having seen it once.",
      priority: 4,
      author: user3,
      finished_at: DateTime.truncate(DateTime.utc_now(), :second),
      assignees: [user2]
    },
    %Task{
      name: "Launch project website",
      description:
        "Develop a system, so that people can easily get in touch with us and keep track of the mission progress.",
      priority: 1,
      author: user3,
      comments: [
        %Comment{
          content: "I'm a great hacker, not do brag. Count me in!",
          author: user1
        }
      ],
      assignees: [user1]
    },
    %Task{
      name: "Launch first group of spaceships",
      description:
        "As the title indicates, this is the target for Stage 1 of the project. Once we gather enough engineers we should focus on this task.",
      priority: 3,
      author: user3,
      comments: []
    }
  ]
})
