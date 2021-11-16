class Backup
  class RemoveSpecified
    module Shared
      private

      def nullify_filtered_dependencies(entry)
        hash_with_filtered = entry.ids_of_all_dependencies_with_filtered(dependencies_to_filter)
        filtered_builds = hash_with_filtered[:filtered_out]&.[](:build)&.map { |id| Build.find(id) }
        filtered_builds&.map(&:nullify_default_dependencies)&.flatten
      end

      def dependencies_to_filter
        {
          build: Build.default_dependencies_symbols_to_nullify
        }
      end
    end
  end
end
  