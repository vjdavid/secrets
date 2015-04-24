# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Agent.create(name: "holis", email: "example@holis.com")
Agent.create(name: "sample", email: "hols@example.com")
Agent.create(name: "crayolis", email: "fail@email.com")

Project.create(name: "project", description: "this is my description")
Project.create(name: "hollis", description: "fake description")
Project.create(name: "sample", description: "atiiii")

Task.create(name: "project", description: "this is my description")
Task.create(name: "hollis", description: "fake description")
Task.create(name: "sample", description: "atiiii")

