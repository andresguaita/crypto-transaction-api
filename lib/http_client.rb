class HttpClient

    def self.get(url, headers: {}, params: {})
      raise NotImplementedError, 'Este método debe ser implementado por una subclase'
    end
  end
  