def expect_method_calls_on(cl, method, call_with, options)
  match_mode = options[:mode] || :including
  allow_instances = options[:allow_instances] || false
  arguments_to_check = options[:arguments_to_check] || :all

  calls_args = []

  allowed = allow_instances ? allow_any_instance_of(cl) : allow(cl)

  allowed.to receive(method).and_wrap_original do |method, *args, &block|
    if arguments_to_check == :all
      calls_args.push(args)
    else
      calls_args.push(args.send(arguments_to_check)) # = args.first, args.second, args.third etc.
    end
    method.call(*args, &block)
  end

  yield

  case match_mode
  when :including
    call_with.each do |args|
      expect(calls_args).to include(args)
    end
  when :match
    expect(call_with).to match_array(calls_args)
  end
end

def nullifies_all_orphaned_builds_dependencies?
  dependencies_to_check = Build.all.map do |build|
    build.default_dependencies_to_nullify
  end.flatten(1)

  yield

  dependencies_to_check.reject! { |d| d.removed? }

  build_ids_to_check = dependencies_to_check.map do |d|
    [d.try(:current_build_id), d.try(:last_build_id)]
  end.flatten(1)

  build_ids_to_check.compact!
  referenced_builds = build_ids_to_check.map { |id| Build.find_by(id: id) }
  !referenced_builds.include?(nil)
end

def get_expected_files(directory, datetime)
  Dir["spec/support/expected_files/#{directory}/**/*.json"].map do |file_path|
    content = File.read(file_path)
    content.gsub(/"[^"]+ UTC"/, "\"#{datetime.to_s}\"")
  end
end
