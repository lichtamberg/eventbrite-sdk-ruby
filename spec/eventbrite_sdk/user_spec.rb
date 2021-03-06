require 'spec_helper'

module EventbriteSDK
  RSpec.describe User do
    describe '.me' do
      it 'returns a new instance with #id as "me"' do
        user = described_class.me

        expect(user.id).to eq('me')
      end
    end

    describe '#verify' do
      context 'when id exists' do
        it 'calls save with `verify`' do
          user = described_class.new('id' => '1')
          allow(EventbriteSDK).to receive(:post)

          user.verify

          expect(EventbriteSDK).
            to have_received(:post).
            with(url: 'users/1/verify')
        end
      end

      context 'when id is absent' do
        it 'returns false' do
          user = described_class.new
          allow(user).to receive(:save)

          expect(user.verify).to eq(false)
        end
      end
    end

    describe '#ticket_groups' do
      it 'returns a new Resource list with a proper url_base' do
        allow(ResourceList).to receive(:new)

        described_class.new(id: '1').ticket_groups

        expect(ResourceList).
          to have_received(:new).
          with(
            url_base: 'users/1/ticket_groups',
             object_class: TicketGroup,
             key: :ticket_groups
           )
      end
    end

    describe '#unverify' do
      context 'when id exists' do
        it 'calls save with `unverify`' do
          user = described_class.new('id' => '1')
          allow(EventbriteSDK).to receive(:post)

          user.unverify

          expect(EventbriteSDK).
            to have_received(:post).
            with(url: 'users/1/unverify')
        end
      end

      context 'when id is absent' do
        it 'returns false' do
          user = described_class.new
          allow(user).to receive(:save)

          expect(user.unverify).to eq(false)
        end
      end
    end
  end
end
