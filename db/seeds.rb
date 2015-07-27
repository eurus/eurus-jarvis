# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#   
# (1..20).each do |i|
#   Artical.create(
#     title: "Lorem ipsum dolor sit amet.",
#     content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dicta ab repellat architecto officia recusandae labore harum nesciunt quo dolor molestiae incidunt magnam reiciendis sit, blanditiis laborum placeat ea nulla omnis perspiciatis facere explicabo excepturi? Sit eaque deserunt dolorum doloremque eos, ullam maxime, nam dolorem odit eum illum ut saepe repellendus ea sunt quos cumque dicta quisquam amet omnis tenetur. Animi modi sequi consectetur aliquid quidem quisquam labore reprehenderit aperiam ipsam, totam, excepturi eum repellendus laboriosam doloribus laborum quae provident perferendis perspiciatis hic. Atque, minus molestias reprehenderit, eligendi consectetur autem dignissimos? Rerum similique explicabo minima id odio eaque natus error officiis.",
#     origin: "http://fortawesome.github.io/Font-Awesome/icons/",
#     user_id: 1)
# end

# 20.times.each do |x|
#   Feedback.create(user_id: 1, content: "what the fuck")
# end
sumary = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Optio odit, maxime iure? Reprehenderit tempora illo deleniti voluptatum totam eos architecto labore ea consequatur! Expedita, corporis recusandae iusto vitae minus facere, et quibusdam ad, voluptate fuga consectetur explicabo ut. Id officia consequatur consectetur deleniti totam neque ad dolore cupiditate reiciendis unde voluptate ratione illo cum itaque iusto dolores, tempora autem. Eligendi obcaecati rerum explicabo libero blanditiis pariatur delectus ex voluptate quis placeat dignissimos quaerat, facere maxime voluptates ad ducimus qui alias iste odio quod veniam. Quos excepturi deserunt iste reprehenderit. Facere laboriosam blanditiis optio voluptas assumenda odio fugiat perferendis, quas hic."
hope = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quos ea cumque, perferendis quisquam molestiae suscipit error cupiditate eos, repellat vitae labore esse similique. Quasi rem quisquam, velit, ea obcaecati assumenda cupiditate, consequatur dolorem eveniet nihil nisi a! Distinctio, totam, veniam! Eum repellendus nihil quae excepturi quibusdam, laborum ducimus debitis totam obcaecati dolore dolor ab harum atque sequi architecto deserunt. Velit nemo atque, at amet doloremque ut et eligendi dicta ipsum ea alias numquam iusto fugiat facilis illo officia delectus ratione esse nisi, saepe aliquam. Consectetur possimus officiis, mollitia modi magnam laborum accusamus, illum voluptatum ad repellat eos odio aperiam ea."
30.times.each do |x|
  Weekly.create(sumary: sumary, hope: hope)
end
