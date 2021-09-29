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
