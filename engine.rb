class Engine
  def lookup(title)
    raise 'Engine::lookup must be overriden in the subclass'
  end

  def name
    raise 'Engine::name must be overriden in the subclass'
  end
end
