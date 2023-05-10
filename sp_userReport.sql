delimiter //
create procedure hoteldb.userReport(IN cpf varchar(11))
begin

 select U.user_cpf as user_cpf,
		U.user_name as user_name,
		COUNT(1) as num_of_bookings,
        SUM(DATEDIFF(B.check_out, B.check_in) * RC.price) as total_value
  from hoteldb.hotel_user U
 inner join hoteldb.booking B on (U.user_cpf = B.user_cpf)
 inner join hoteldb.room R on (R.room_id = B.room_id)
 inner join hoteldb.room_category RC on (RC.room_category_id = R.room_category_id)
 where U.user_cpf = cpf and B.status = 'I';

end//
delimiter ;