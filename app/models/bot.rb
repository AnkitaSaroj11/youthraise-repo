include  ActionView::Helpers::TextHelper
module Bot
  MODEL = "gpt-3.5-turbo".freeze
  MAX_TOKENS = 500

  def self.generate_personal_message(messageable)
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: MODEL,
        max_tokens: MAX_TOKENS,
        messages: [
          role: 'user',
          content: messageable.personal_message_prompt
        ],
        n: 1
      }
    )

    text = response.dig("choices", 0, "message", "content")
    PersonalMessage.create!(
      message: text,
      bot_response: response,
      messageable: messageable,
    )
  end

end