class Attempt
  attr_reader :submission, :results, :message
  def initialize(input)
    @submission = format(input)
    @results    = []
  end

  def check!
    temp_container = []
    temp_message   = ""
    unless unauthorized?
        DB.transaction do 
          begin
            temp_container << DB.fetch(submission).to_a  
          rescue Sequel::ForeignKeyConstraintViolation, Sequel::DatabaseError => e
            temp_message += e.to_s
          end
          raise Sequel::Rollback  
        end
      @results = temp_container.flatten
      @message = temp_message
    end
  end

  def message
    if unauthorized?
      "Sorry, you do not have permission to do that."
    else
      @message
    end
  end

  def unauthorized?
    submission.downcase.include?("drop ") || submission.downcase.include?("truncate ")
  end

  def format(input)
    input += ";" unless input[-1] == ";"
    input.gsub('"', "'")
  end
end