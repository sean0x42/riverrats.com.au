# frozen_string_literal: true

# A mailer for sending information to players.
class PlayerMailer < ApplicationMailer
  def welcome(player_id, password)
    @player = Player.find(player_id)
    return if @player.nil?

    @password = password
    email = if @player.email.nil? || @player.email.blank?
              'riverratspl@gmail.com'
            else
              @player.email
            end
    email_with_name = "#{@player.full_name} <#{email}>"
    mail(to: email_with_name, subject: t('mailer.player.welcome.subject'))
  end
end
