local util = {}

util.tbl_contains = function(t, v)
  for _, value in pairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

function single_char_filter(input, env)
  local on = env.engine.context:get_option("single_char")
  local exclude = { "……", "——" }
  for cand in input:iter() do
    if not on or utf8.len(cand.text) == 1 or util.tbl_contains(exclude, cand.text) then
      yield(cand)
    end
  end
end
