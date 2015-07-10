# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#   
(1..20).each do |i|
  Artical.create(
    title: "Lorem ipsum dolor sit amet.",
    content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dicta ab repellat architecto officia recusandae labore harum nesciunt quo dolor molestiae incidunt magnam reiciendis sit, blanditiis laborum placeat ea nulla omnis perspiciatis facere explicabo excepturi? Sit eaque deserunt dolorum doloremque eos, ullam maxime, nam dolorem odit eum illum ut saepe repellendus ea sunt quos cumque dicta quisquam amet omnis tenetur. Animi modi sequi consectetur aliquid quidem quisquam labore reprehenderit aperiam ipsam, totam, excepturi eum repellendus laboriosam doloribus laborum quae provident perferendis perspiciatis hic. Atque, minus molestias reprehenderit, eligendi consectetur autem dignissimos? Rerum similique explicabo minima id odio eaque natus error officiis.",
    origin: "http://fortawesome.github.io/Font-Awesome/icons/",
    user_id: 1)
end
