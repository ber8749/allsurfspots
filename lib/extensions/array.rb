class Array
  def to_series
    self.reject(&:blank?).to_sentence
  end
end