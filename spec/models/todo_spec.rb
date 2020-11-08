# frozen_string_literal: true

require "rails_helper"

describe Todo do
  describe ".create_from_telegram_message" do
    context "when message id todolike" do
      let(:todo) { instance_double(described_class) }
      let(:telegram_message) do
        instance_double(TelegramMessage, todolike?: true, text: "New todo", photo_link: nil)
      end

      before do
        allow(TelegramMessage).to receive(:new).and_return(telegram_message)
        allow(Todolist).to receive(:find_or_create_from_telegram_message).and_return(true)
        allow(described_class).to receive(:new).and_return(todo)
        allow(todo).to receive(:save).and_return(todo)
      end

      it "creates todo from telegram message" do
        todo_from_telegram_message = described_class.create_from_telegram_message(bot: {}, message: {})
        expect(todo_from_telegram_message).to eq todo
      end
    end

    context "when message is NOT todolike" do
      let(:telegram_message) { instance_double(TelegramMessage, todolike?: false) }

      before do
        allow(TelegramMessage).to receive(:new).and_return(telegram_message)
      end

      it "returns nil" do
        todo_from_telegram_message = described_class.create_from_telegram_message(bot: {}, message: {})

        expect(todo_from_telegram_message).to eq nil
      end
    end
  end

  describe "#status" do
    it "has status `do` on create" do
      todo = create(:todo, todolist: create(:todolist))

      expect(todo.do?).to be true
    end
  end
end
