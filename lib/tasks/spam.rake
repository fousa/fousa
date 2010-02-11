namespace :spam do

  desc "Remove all the spam"
  task :remove => :environment do
    puts "- remove spam"
    Comment.all.each do |comment|
      puts "* removed comment: #{comment.id}"
      comment.destroy if (comment.spam == true || comment.spam.nil?) && !comment.personal_comment
    end
  end

end