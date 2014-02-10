/*
 *  Type.h
 *  Meme
 *
 *  Created by NTU Mobile Lab on 2010/3/17.
 *  Copyright 2010 Nation Taiwan University. All rights reserved.
 *
 */
typedef enum {
    kLineShape = 0,
    kPicShape,
    kDotShape
} ShapeType;


typedef enum {
	Oblique_high = 0,
	Oblique_low,
	Straight_high,
	Straight_low,
} CutType;


typedef enum {
	cut = 0,
	perm,
	style
} Stage;