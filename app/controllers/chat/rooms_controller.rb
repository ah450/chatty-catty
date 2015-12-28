class Chat::RoomsController < FayeRails::Controller
  channel '/rooms/**' do
    filter :in do
      begin
        token = data['ext']['token']
        user = User.find_by_token token
        drop if user.nil?
        msg = message.clone
        msg['data'] = data.reject { |key, value| key == 'ext'}
        msg['data']['author'] = user.as_json
        modify msg
      rescue
        drop
      end
    end
  end
end