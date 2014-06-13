module Tick
  class Job < Hashie::Mash
    # include Tick::Resource

    def save
      if id = (self[:id] || self['id'])
        response = Tick.client.put("/api/v1/jobs/#{id}", to_hash)
        merge! response.body
      else
        merge! self.class.create(attrs)
      end
      self
    end

    def cancel
      id = to_hash['id'] || raise('Cannot cancel unsaved job')
      self.class.destroy(to_hash['id'])
    end

    class << self
      def find(id)
        process_response Tick.client.get("/api/v1/jobs/#{id}")
      end

      def create(attrs = {})
        process_response Tick.client.post("/api/v1/jobs", attrs)
      end

      def destroy(id)
        process_response Tick.client.delete("/api/v1/jobs/#{id}")
      end

      private
      def process_response(response)
        new(response.body)
      end
    end
  end
end
