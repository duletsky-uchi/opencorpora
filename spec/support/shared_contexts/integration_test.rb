require 'rails_helper'

shared_context 'with forbidden schema' do
  schema type: :object,
         required: [:errors],
         properties: {
           errors: {
             type: :array,
             items: {
               properties: {
                 title: { type: :string },
                 code: { type: :string },
                 status: { type: :string }
               }
             }
           }
         }
end

shared_context 'with not found schema' do
  schema type: :object,
         required: [:error],
         properties: {
           error: { type: :string }
         }
end
