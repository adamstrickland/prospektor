require 'spec_helper'

describe 'videos at' do
  describe '/views' do
    describe '/videos' do
      describe '/player' do
        # it 'with a title' do
        #   title = 'Somethign'
        #   assigns[:title] = title
        #   render('/videos/player.html.haml')
        #   response.should have_tag('head title', title)
        # end
        
        it 'renders using partial' do
          template.should_receive(:render).with(:partial => 'player_config')
          render '/videos/player.html.haml'
        end
        
        it 'with a key' do
          key = 'OU9w7inLLKiu'
          assigns[:key] = key
          render('/videos/_player_config.html.haml')
          response.should have_tag('script', /^.*#{key}.*$/)
          # response.body.should match(/^.*#{key}.*$/)
        end
        
        
      end
    end
  end
end