package org.studywithme.domain;

import lombok.Data;

@Data
public class ReviewVoteHistoryVO {
	private int reviewVoteNo;
	private int cafeNo;
	private String ReviewNo;
	private String action;
}
