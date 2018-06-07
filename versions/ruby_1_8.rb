module Ruby_1_8
	def gc_stat()
		puts "Description"
		gcstat = GC.stat
		puts "Minor garbage collection is #{gcstat[:minor_gc_count]}"
		puts "Miajor garbage collection is #{gcstat[:major_gc_count]}"

		puts "Heaps informastion:"
		puts "	page numbers 
	heap_allocated_pages   : #{gcstat[:heap_allocated_pages]}
	heap_sorted_length     : #{gcstat[:heap_sorted_length]}
already malloced 	heap_allocatable_pages : #{gcstat[:heap_allocatable_pages]} 
Slots
heap_available_slots   : #{gcstat[:heap_available_slots]}

Number of live objects  heap_live_slots     : #{gcstat[:heap_live_slots]}
Number of empty slots   heap_free_slots : #{gcstat[:heap_free_slots]}
heap_final_slots   : #{gcstat[:heap_final_slots]}
Count of OLD objetcs: 	heap_marked_slots     : #{gcstat[:heap_marked_slots]}
page numbers 
Eden pages are heap pages which contain at least one live object in them
heap_eden_pages   : #{gcstat[:heap_eden_pages]}
Tomb pages contain no live objects					
heap_tomb_pages     : #{gcstat[:heap_tomb_pages]}
		"
		puts "cumulative allocated/freed numbers"
		puts "{ :total_allocated_pages=>#{gcstat[:total_allocated_pages]},
  :total_freed_pages=>#{gcstat[:total_freed_pages]},
  :total_allocated_objects=>#{gcstat[:total_allocated_objects]},
  :total_freed_objects=>#{gcstat[:total_freed_objects]}
  }"

		puts "garbage collection thresholds."
		puts "{
 :malloc_increase_bytes=>#{gcstat[:malloc_increase_bytes]},
 :malloc_increase_bytes_limit=>#{gcstat[:malloc_increase_bytes_limit]},
 :remembered_wb_unprotected_objects=>#{gcstat[:remembered_wb_unprotected_objects]},
 :remembered_wb_unprotected_objects_limit=>#{gcstat[:remembered_wb_unprotected_objects_limit]},
 :old_objects=>#{gcstat[:old_objects]},
 :old_objects_limit=>#{gcstat[:old_objects_limit]},
 :oldmalloc_increase_bytes=>#{gcstat[:oldmalloc_increase_bytes]},
 :oldmalloc_increase_bytes_limit=>#{gcstat[:oldmalloc_increase_bytes_limit]}
}"
	end

	def forced_gc(i=0, forced_full_colection=nil, forced_minor_colection=nil)
		if [forced_full_colection, forced_minor_colection].include?(i)
			full_mark, minor_mark = (forced_full_colection === i), (forced_minor_colection === i)

			GC.start(full_mark: (full_mark || !minor_mark), immediate_sweep: true)
			
			puts ((full_mark || !minor_mark)) ? "FORCE" : "MINOR"
		end
	end
end