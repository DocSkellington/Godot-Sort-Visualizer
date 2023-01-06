extends "res://scenes/objects/sorters/sorter.gd"

# https://en.wikipedia.org/wiki/Bubble_sort
# the simplest sorting algorithm that works by repeatedly
# swapping the adjacent elements if they are in the wrong order
#
# time complexity: O(N^2)

var _curr_index : int = 0


# override
func setup(data_size : int, priority_callback : FuncRef):
	.setup(data_size, priority_callback)
	
	_curr_index = 0

# override
func next_step() -> Dictionary:
	var changed : bool = false
	var indexes : Array
	
	while true:
		for i in range(_curr_index, _data_size-1):
			if _priority_callback.call_func(i, i+1):
				changed = true
				indexes.append(i)
				indexes.append(i+1)
				_curr_index = i+1
				break
		
		# if no change happened then we know we're done
		# but! if we didn't start checking from 0, recheck 
		if changed == false && _curr_index > 0:
			_curr_index = 0
		else:
			break
	
	return {"done":!changed, "indexes":indexes}

# override
func skip_to_last_step() -> Array:
	var indexes : Array
	for i in _data_size: indexes.append(i)
	
	while true:
		var changed : bool = false
		for i in range(0, _data_size-1):
			if _priority_callback.call_func(indexes[i], indexes[i+1]):
				changed = true
				var temp_i = indexes[i]
				indexes[i] = indexes[i+1]
				indexes[i+1] = temp_i
		if changed == false: break
	
	return indexes
