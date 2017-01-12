#include <iostream>
using std::cout;
using std::endl;

bool IsRepetitionStart(unsigned char *src, int srcLeft) {
	if(srcLeft >= 2 && *src == *(src+1) && *src == *(src+2)) {
		return true;
	}
	return false;
}

int GetRepetitionCount(unsigned char *src, int srcLeft) {
	unsigned char *c = src;
	int count = 0;
	for(; count <= srcLeft; ++count) {
		if(*(src+count) != *c) {
			break;
		}
	}
	return count;
}

int GetNonRepetitionCount(unsigned char *src, int srcLeft) {
	unsigned char *c = src;
	int count = 0;
	for(; count <= srcLeft-1; ++count) {
		if(*(src+count) == *(src+count+1)) {
			break;
		}
	}
	return count;
}

int Rle_Encode(unsigned char *inbuf, int inSize, unsigned char *outbuf, int outBufSize)
{
    unsigned char *src = inbuf;
    int i;
    int encSize = 0;
    int srcLeft = inSize;

    while(srcLeft > 0)
    {
        int count = 0;
        if(IsRepetitionStart(src, srcLeft)) /*是否连续三个字节数据相同？*/
        {
            if((encSize + 2) > outBufSize) /*输出缓冲区空间不够了*/
            {
                return -1;
            }
            count = GetRepetitionCount(src, srcLeft);
            outbuf[encSize++] = count | 0x80;
            outbuf[encSize++] = *src;
            src += count;
            srcLeft -= count;
        }
        else
        {
            count = GetNonRepetitionCount(src, srcLeft);
            if((encSize + count + 1) > outBufSize) /*输出缓冲区空间不够了*/
            {
                return -1;
            }
            outbuf[encSize++] = count;
            for(i = 0; i < count; i++) /*逐个复制这些数据*/
            {
                outbuf[encSize++] = *src++;;
            }
            srcLeft -= count;
        }
    }
    return encSize;
}


int Rle_Decode(unsigned char *inbuf, int inSize, unsigned char *outbuf, int onuBufSize)
{
    unsigned char *src = inbuf;
    int i;
    int decSize = 0;
    int count = 0;

    while(src < (inbuf + inSize))
    {
        unsigned char sign = *src++;
        int count = sign & 0x7F;
        if((decSize + count) > onuBufSize) /*输出缓冲区空间不够了*/
        {
            return -1;
        }
        if((sign & 0x80) == 0x80) /*连续重复数据标志*/
        {
            for(i = 0; i < count; i++)
            {
                outbuf[decSize++] = *src;
            }
            src++;
        }
        else
        {
            for(i = 0; i < count; i++)
            {
                outbuf[decSize++] = *src++;
            }
        }
    }

    return decSize;
}


int main() {
	unsigned char *inbuf = new unsigned char[10]{'A','A','A','A','B','B','B','B','B','C'};
	unsigned char *outbuf = new unsigned char[30]{};
	int inSize = 10;
	int outBufSize = 30;
	
	int outNum = Rle_Encode(inbuf,inSize,outbuf,outBufSize);
	for(int x = 0; x < outNum; ++x) {
		cout << outbuf[x] << " ";
	}
	cout << endl;
	cout << outNum << endl;
	
	unsigned char *decodebuf = new unsigned char[10];
	int decodeSize = 10;
	Rle_Decode(outbuf,outNum,decodebuf,decodeSize);
	for(int x = 0; x < decodeSize; ++x) {
		cout << decodebuf[x] << " ";
	}
	cout << endl;
}
