function [ fftpurity ] = fftpurity( signalpath, window)

test = 0;

window = double(window);

[signal,Fs] = audioread(signalpath);

N = 2^(ceil(log2(length(signal))));

maszeros = zeros(N-length(signal),1);

signal_in = [signal; maszeros];
s = [signal; maszeros];

if (window == double('Hann'))
    signal_in = hann_window(signal_in);
    s = hann_window(s);
elseif (window == double('Hemm'))
    signal_in = hemming_window(signal_in);
    s = hemming_window(s);
elseif (window == double('Rect'))
    signal_in = rectangular_window(signal_in);
    s = rectangular_window(s);
end

plot(signal_in);
figure;

for i = 1:1:(log2(length(s(:,1))))            %���������� ����� �� ������������� ���
    
    polovina = length(s)/(2^i);                 %�������� �������� ���
    konec = length(s)/(2^(i-1));                %����� �������� ���
    cK = 0;                                     %����� �������� � N �������� ���
    
    for k = 1:1:length(s(:,1))                  
        
        cK = cK + 1; 
        
        if(cK<=polovina)
            s(k,i+1)=s(k,i)+s(k+polovina,i);
        elseif(cK<=konec)
            s(k,i+1)=(s(k,i)-s(k-polovina,i))*w(cK-polovina-1,konec);
            if(cK==konec)
                cK = 0;
            end
        
        end    
        
    end
    
    
end

s1=s(:,end);

for i = 1:1:log2(length(s1))-1                                %������������ ����������� ���
    
    polovina = 2^i;                                         %�������� �������� ���
    konec = 2^(i+1);                                        %����� �������� ���
    cK = 0;                                                 %����� �������� � N �������� ���
    cP = 1;                                                 %��������� �������� N ��������� ���
    nP = 0;                                                 %���������� ���������� �������
        for k = 1:1:length(s1(:,1))                             
        
            cK = cK + 1;
        
            if(mod(cK,2)==1)
                s1(k,i+1)=s1(cP+(konec*nP),i);
            elseif(mod(cK,2)==0)
                s1(k,i+1)=s1(cP+polovina+(konec*nP),i);
                cP = cP + 1;
            end
            
            if(cK==konec)
                    cK = 0;
                    cP = 1;
                    nP = nP + 1;
            end
        
        end
    
end

signal_out = s1(:,end);

f = zeros(length(signal_out),1);
for i = 1 : length(signal_out)
    f(i) = (i-1)*Fs/length(signal_out);
end

subplot(2,1,1); stem(f,2*abs(fft(signal_in))/length(signal_in)); grid on; title('��������� fft');
subplot(2,1,2); stem(f,2*abs(signal_out)/length(signal_out)); grid on; title('��������� fftpurity');


end

