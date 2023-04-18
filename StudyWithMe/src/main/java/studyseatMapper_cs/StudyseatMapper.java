package studyseatMapper_cs;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import studyseatdomain_cs.SeatVO;

public interface StudyseatMapper {
	public List<SeatVO> readuseseat(Long cafeno);
	public Map<String, Object> getmyreservationInfo(@Param("user_id")String user_id, @Param("category")String category);
	public void insert(@Param("cafe_no")int cafe_no, @Param("num_using")int num_using, @Param("user_id")String user_id);
	public boolean isSeatAvailable(@Param("cafe_no")int cafe_no, @Param("num_using")int num_using);
}
