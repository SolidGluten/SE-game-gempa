class_name DestroyParticle
extends CPUParticles2D

func _ready() -> void:
    self.emitting = true
    # finished.connect(self.queue_free)
