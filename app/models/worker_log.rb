class WorkerLog < ActiveRecord::Base

  default_scope order('id desc')
  
  def self.clear
    WorkerLog.delete_all
  end

  def self.log(status)
    WorkerLog.create!(:status => status)
  end

  def self.error(error)
    WorkerLog.create!(:status => 'ERROR', :last_error => error)
  end
  
end
