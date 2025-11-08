/// ONLINE
// %arg0: The name of the world object
// %arg1: The name of the player object
// %arg2: The name of the player2 object if it exists
if(!%arg0.@race){
	#if STUDIO
		if(argument0){
	#endif
	#if not STUDIO
		#if not RENEX
			if(room != rSelectStage){
		#endif
		#if RENEX
			if(room != rmInit && room != rmTitle && room != rmMenu && room != rmOptions){
		#endif
	#endif
		buffer_clear(%arg0.@buffer);
		@p = %arg1;
		#if PLAYER2
			if(!instance_exists(@p)){
				@p = %arg2;
			}
		#endif
		if(instance_exists(@p)){
			#if not GMNET
				buffer_write_uint8(%arg0.@buffer, 5);
				#if STUDIO
					buffer_write_uint8(%arg0.@buffer, global.grav);
				#endif
				#if not STUDIO
					if(@p == %arg1){
						buffer_write_uint8(%arg0.@buffer, 0);
					}else{
						buffer_write_uint8(%arg0.@buffer, 1);
					}
				#endif
				buffer_write_int32(%arg0.@buffer, @p.x);
				buffer_write_float64(%arg0.@buffer, @p.y);
				buffer_write_int16(%arg0.@buffer, room);
			#endif
			#if GMNET
				buffer_write_u8(%arg0.@buffer, 5);
				#if STUDIO
					buffer_write_u8(%arg0.@buffer, global.grav);
				#endif
				#if not STUDIO
					if(@p == %arg1){
						buffer_write_u8(%arg0.@buffer, 0);
					}else{
						buffer_write_u8(%arg0.@buffer, 1);
					}
				#endif
				buffer_write_i32(%arg0.@buffer, @p.x);
				buffer_write_double(%arg0.@buffer, @p.y);
				buffer_write_i16(%arg0.@buffer, room);
			#endif
			socket_write_message(%arg0.@socket, %arg0.@buffer);
		}
	}
}
