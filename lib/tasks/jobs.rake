namespace :jobs do
  desc "Update job install statuses"
  task update_install_status: :environment do
    Job.where("install_end_date < ?", Date.today).each do |job|
      job.update(
        installed: true,
        install_date: "#{job.install_start_date} - #{job.install_end_date}"
      )
    end
  end
end
