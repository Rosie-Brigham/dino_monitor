puts "Image resize script"
Submission.all.find_in_batches do |group|
  group.each { |submission| ImageVariantWorker.perform_async(submission) }
end
puts "DONE! Lets hope it worked!"
