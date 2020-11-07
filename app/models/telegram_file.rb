# frozen_string_literal: true

class TelegramFile
  def initialize(bot:, file_id:)
    @bot = bot
    @file_id = file_id
  end

  def link
    "https://api.telegram.org/file/bot#{bot.token}/#{file_path}"
  end

  private

  attr_reader :bot, :file_id

  def file_path
    file.dig("result", "file_path")
  end

  def file
    bot.get_file(file_id: file_id)
  end
end
