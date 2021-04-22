class Application < Sinatra::Base
  get '/' do
    slim :dashboard
  end

  get '/lessons' do
    @lessons = Lesson.all
    slim :lessons_index
  end

  get '/lessons/:id' do |id|
    @lesson = Lesson.number(params[:id])
    if params[:attempt]
      @attempt = Attempt.new(params[:attempt])
      @attempt.check!
    end
    slim :lesson_show, :escape_html => true
  end

  get '/playground' do
    if params[:attempt]
      @attempt = Attempt.new(params[:attempt])
      @attempt.check!
    end
    slim :playground, :escape_html => true
  end

  get '/jupyter' do
    slim :jupyter, :escape_html => true
  end

  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end
  end
end
