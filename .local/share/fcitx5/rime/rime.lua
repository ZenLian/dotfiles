function single_char_filter(input, env)
  on = env.engine.context:get_option("single_char")
  for cand in input:iter() do
    if not on or utf8.len(cand.text) == 1 then
      yield(cand)
    end
  end
end
