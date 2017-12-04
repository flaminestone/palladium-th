require 'securerandom'
require 'time'
class Invite < Sequel::Model
  plugin :timestamps
  one_to_one :user

  def self.create_new(_username = nil)
    unless _username.nil?
      if User[email: _username].nil?
        halt 400, 'Username is incorrect or not exist'
      else
        invite = Invite.create(token: SecureRandom.hex)
        invite.expiration_data = invite.created_at + 10 * 60
        User[email: _username].invite.destroy unless User[email: _username].invite.nil?
        User[email: _username].invite = invite
      end
    end
    invite
  end

  def self.check_link_validation(link)
    case
      when Invite[token: link].nil?
        return [false, ['token_not_found']]
      when Invite[token: link].expiration_data - Time.now < 0
        return [false, ['token is expired']]
      else
        return [true, []]
    end
  end
end
