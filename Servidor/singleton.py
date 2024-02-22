class SingletonMeta(type):
    """Singleton metaclass."""

    _instances = {}

    def __call__(cls, *args, **kwargs):
        """Return the same instance of the class."""
        if cls not in cls._instances:
            cls._instances[cls] = super(SingletonMeta, cls).__call__(
                *args, **kwargs
            )

        return cls._instances[cls]
