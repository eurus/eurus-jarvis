# sumary = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Optio odit, maxime iure? Reprehenderit tempora illo deleniti voluptatum totam eos architecto labore ea consequatur! Expedita, corporis recusandae iusto vitae minus facere, et quibusdam ad, voluptate fuga consectetur explicabo ut. Id officia consequatur consectetur deleniti totam neque ad dolore cupiditate reiciendis unde voluptate ratione illo cum itaque iusto dolores, tempora autem. Eligendi obcaecati rerum explicabo libero blanditiis pariatur delectus ex voluptate quis placeat dignissimos quaerat, facere maxime voluptates ad ducimus qui alias iste odio quod veniam. Quos excepturi deserunt iste reprehenderit. Facere laboriosam blanditiis optio voluptas assumenda odio fugiat perferendis, quas hic."
# hope = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quos ea cumque, perferendis quisquam molestiae suscipit error cupiditate eos, repellat vitae labore esse similique. Quasi rem quisquam, velit, ea obcaecati assumenda cupiditate, consequatur dolorem eveniet nihil nisi a! Distinctio, totam, veniam! Eum repellendus nihil quae excepturi quibusdam, laborum ducimus debitis totam obcaecati dolore dolor ab harum atque sequi architecto deserunt. Velit nemo atque, at amet doloremque ut et eligendi dicta ipsum ea alias numquam iusto fugiat facilis illo officia delectus ratione esse nisi, saepe aliquam. Consectetur possimus officiis, mollitia modi magnam laborum accusamus, illum voluptatum ad repellat eos odio aperiam ea."
# 30.times.each do |x|
#   Weekly.create(sumary: sumary, hope: hope)
# end

### 7.30 dump data
require 'csv'
CSV.foreach('dump_data/project.csv', headers: true, col_sep: ',') do |row|
  ap row
end
