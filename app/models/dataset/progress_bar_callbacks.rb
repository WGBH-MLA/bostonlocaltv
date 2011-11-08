module Dataset  
  module ProgressBarCallbacks
    extend ActiveSupport::Concern
    require 'progressbar'

    included do
      attr_writer :progress_bar

      before_process_record { progress_bar.inc }
      after_process { progress_bar.finish }
    end

    module InstanceMethods
      
      def progress_bar title = "processing", out = STDERR 
        @progress_bar ||= ProgressBar.new title, records.length, out
      end
    end
  end
end

