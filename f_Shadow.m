function ret = f_Shadow(historical, simulated)
   ret = historical / simulated;
   ret = 1 - ret;
   if ret < 0 
       ret = 0;
   end
   if ret > 1
       ret = 1;
   end
   
   if (ret == Inf || isnan(ret)) % not defined
       ret = 1;
   end
   
   
end