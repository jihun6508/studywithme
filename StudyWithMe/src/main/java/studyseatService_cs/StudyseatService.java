package studyseatService_cs;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import studyseatdomain_cs.SeatVO;


public interface StudyseatService {
	public List<SeatVO> useseat(Long cafeno);
	public Map<String, Object> myuseseat(String id);
	public void insertseat(int cafe_no, int num_using, String id);
}
