module TasksHelper
  LABEL_COLORS = {
    "Bug"     => { base: "bg-red-50 text-red-700 border-red-200",     checked: "peer-checked:bg-red-100 peer-checked:border-red-500 peer-checked:ring-1 peer-checked:ring-red-400" },
    "Feature" => { base: "bg-blue-50 text-blue-700 border-blue-200",   checked: "peer-checked:bg-blue-100 peer-checked:border-blue-500 peer-checked:ring-1 peer-checked:ring-blue-400" },
    "Improvement"   => { base: "bg-amber-50 text-amber-700 border-amber-200", checked: "peer-checked:bg-amber-100 peer-checked:border-amber-500 peer-checked:ring-1 peer-checked:ring-amber-400" },
    "Documentation"    => { base: "bg-green-50 text-green-700 border-green-200", checked: "peer-checked:bg-green-100 peer-checked:border-green-500 peer-checked:ring-1 peer-checked:ring-green-400" },
    "Design"  => { base: "bg-purple-50 text-purple-700 border-purple-200", checked: "peer-checked:bg-purple-100 peer-checked:border-purple-500 peer-checked:ring-1 peer-checked:ring-purple-400" },
    "Testing" => { base: "bg-teal-50 text-teal-700 border-teal-200",   checked: "peer-checked:bg-teal-100 peer-checked:border-teal-500 peer-checked:ring-1 peer-checked:ring-teal-400" }
  }.freeze

  LABEL_DOT_COLORS = {
    "Bug"     => "#f87171",
    "Feature" => "#60a5fa",
    "Chore"   => "#fbbf24",
    "Docs"    => "#4ade80",
    "Design"  => "#a78bfa",
    "Testing" => "#2dd4bf"
  }.freeze

  STORY_POINT_COLORS = {
    "XS"     => { base: "bg-red-50 text-red-700 border-red-200",     checked: "peer-checked:bg-red-100 peer-checked:border-red-500 peer-checked:ring-1 peer-checked:ring-red-400" },
    "S"   => { base: "bg-blue-50 text-blue-700 border-blue-200",   checked: "peer-checked:bg-blue-100 peer-checked:border-blue-500 peer-checked:ring-1 peer-checked:ring-blue-400" },
    "M"   => { base: "bg-purple-50 text-purple-700 border-purple-200", checked: "peer-checked:bg-purple-100 peer-checked:border-purple-500 peer-checked:ring-1 peer-checked:ring-purple-400" },
    "L"   => { base: "bg-green-50 text-green-700 border-green-200", checked: "peer-checked:bg-green-100 peer-checked:border-green-500 peer-checked:ring-1 peer-checked:ring-green-400" },
    "XL"   => { base: "bg-pink-50 text-pink-700 border-pink-200", checked: "peer-checked:bg-pink-100 peer-checked:border-pink-500 peer-checked:ring-1 peer-checked:ring-pink-400" },
    "XXL" => { base: "bg-teal-50 text-teal-700 border-teal-200",   checked: "peer-checked:bg-teal-100 peer-checked:border-teal-500 peer-checked:ring-1 peer-checked:ring-teal-400" },
    "EPIC" => { base: "bg-yellow-50 text-teal-700 border-yellow-200",   checked: "peer-checked:bg-yellow-100 peer-checked:border-yellow-500 peer-checked:ring-1 peer-checked:ring-yellow-400" }
  }.freeze

  TASK_TYPE_COLORS = {
    "Critical" => { base: "bg-blue-50 text-blue-700 border-blue-200",     checked: "peer-checked:bg-blue-100 peer-checked:border-blue-500 peer-checked:ring-1 peer-checked:ring-blue-400" },
    "High"   => { base: "bg-red-50 text-red-700 border-red-200",        checked: "peer-checked:bg-red-100 peer-checked:border-red-500 peer-checked:ring-1 peer-checked:ring-red-400" },
    "Low"  => { base: "bg-purple-50 text-purple-700 border-purple-200", checked: "peer-checked:bg-purple-100 peer-checked:border-purple-500 peer-checked:ring-1 peer-checked:ring-purple-400" },
    "Medium"  => { base: "bg-amber-50 text-amber-700 border-amber-200",  checked: "peer-checked:bg-amber-100 peer-checked:border-amber-500 peer-checked:ring-1 peer-checked:ring-amber-400" },
  }.freeze

  FALLBACK_COLORS = {
    base:    "bg-gray-50 text-gray-700 border-gray-200",
    checked: "peer-checked:bg-gray-100 peer-checked:border-gray-500 peer-checked:ring-1 peer-checked:ring-gray-400"
  }.freeze

  def label_pill_classes(name)
    LABEL_COLORS[name] || FALLBACK_COLORS
  end

  def label_dot_color(name)
    LABEL_DOT_COLORS[name] || "#9ca3af"
  end

  def story_point_pill_classes(name)
    STORY_POINT_COLORS[name.to_s] || FALLBACK_COLORS
  end

  def task_type_pill_classes(name)
    TASK_TYPE_COLORS[name] || FALLBACK_COLORS
  end

  def task_type_svg_icon(name)
    paths = {
      "Story" => '<path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z"/>',
      "Bug"   => '<path stroke-linecap="round" stroke-linejoin="round" d="M12 12.75c-2.5 0-4.5-1.119-4.5-2.5S9.5 7.75 12 7.75s4.5 1.119 4.5 2.5-2 2.5-4.5 2.5Z"/><path stroke-linecap="round" stroke-linejoin="round" d="M7.5 10.25H4m16 0h-3.5M12 12.75v3.5m0 0c-2.5 0-4.5.896-4.5 2S9.5 20.25 12 20.25s4.5-.896 4.5-2-2-2-4.5-2Zm-4.5 0H4m16 0h-3.5M8.25 6.5c0-1.243 1.679-2.25 3.75-2.25s3.75 1.007 3.75 2.25M8.25 6.5l-2-2.5m9.5 2.5 2-2.5"/>',
      "Epic"  => '<path stroke-linecap="round" stroke-linejoin="round" d="m3.75 13.5 10.5-11.25L12 10.5h8.25L9.75 21.75 12 13.5H3.75Z"/>',
      "Task"  => '<path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"/>',
      "Spike" => '<path stroke-linecap="round" stroke-linejoin="round" d="M9.75 3.104v5.714a2.25 2.25 0 0 1-.659 1.591L5 14.5M9.75 3.104c-.251.023-.501.05-.75.082m.75-.082a24.301 24.301 0 0 1 4.5 0m0 0v5.714c0 .597.237 1.17.659 1.591L19.8 15.3M14.25 3.104c.251.023.501.05.75.082M19.8 15.3l-1.57.393A9.065 9.065 0 0 1 12 15a9.065 9.065 0 0 1-6.23-.693L5 14.5m14.8.8 1.402 1.402c1.232 1.232.65 3.318-1.067 3.611A48.309 48.309 0 0 1 12 21c-2.773 0-5.491-.235-8.135-.687-1.718-.293-2.3-2.379-1.067-3.61L5 14.5"/>'
    }
    path = paths[name] || '<path stroke-linecap="round" stroke-linejoin="round" d="M9.568 3H5.25A2.25 2.25 0 0 0 3 5.25v4.318c0 .597.237 1.17.659 1.591l9.581 9.581c.699.699 1.78.872 2.607.33a18.095 18.095 0 0 0 5.223-5.223c.542-.827.369-1.908-.33-2.607L11.16 3.66A2.25 2.25 0 0 0 9.568 3Z"/>'
    %(<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" width="13" height="13" aria-hidden="true" style="flex-shrink:0">#{path}</svg>).html_safe
  end

  def label_dot_svg(name)
    color = label_dot_color(name)
    %(<svg xmlns="http://www.w3.org/2000/svg" width="8" height="8" viewBox="0 0 8 8" aria-hidden="true" style="flex-shrink:0"><circle cx="4" cy="4" r="4" fill="#{color}"/></svg>).html_safe
  end
end
