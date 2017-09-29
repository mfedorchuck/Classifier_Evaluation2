function NewRefAltArr = CompByRef(ArrOfValues, num)

% Excluded: NofBest, PVal
% 
% Input: 
%   ArrOfValues - 3D array of all the binariszed images [Amount_Of_Images, 
%   Length, Width]
%
% Output: 
%   OutTable - table with summed marks for every clasification system (table)
%   NofBest - Number of the best clasification system (int8)

z = size(ArrOfValues,1);

Ptest(1:z,1:z,1:z) = 0;
PQmark(1:z,1:z,1:z) = 0;
AltPQmark(1:z,1:z,1:z) = 0;

for j = 1:z
    R(:,:) = ArrOfValues(j,:,:);
    fprintf('%d ',j);

    for k = 1:z
        BinName{k,1} = sprintf('Method %d', k);
        P(:,:) = ArrOfValues(k,:,:);
        
        for e = 1:z
            if e ~= j && e ~= k
                Q(:,:) = ArrOfValues(e,:,:);
            
                PnQR(:,:) = R(:,:) & P(:,:) & ~Q(:,:);
                NPnQR = sum(sum(PnQR(:,:)));
                nPQR(:,:) = R(:,:) & ~P(:,:) & Q(:,:);
                NnPQR = sum(sum(nPQR(:,:)));
                NPQ = NPnQR + NnPQR;

                if NPnQR == NnPQR
                    Ptest(j,k,e) = 1;
                    PQmark(j,k,e) = 0;
                    AltPQmark(j,k,e) = 0;
                
                elseif NPnQR > NnPQR
                    Ptest(j,k,e) = sum(binopdf(NPnQR:NPQ,NPQ,0.5));
                    PQmark(j,k,e) = 1;
                
                    if Ptest(j,k,e) < 0.01
                        AltPQmark(j,k,e) = 1;
                    end
                
            else
                Ptest(j,k,e) = 0;
                PQmark(j,k,e) = 0;
                AltPQmark(j,k,e) = 0;
            end
            end
    end
end

OutArr(:,:,:) = PQmark(:,:,:); 
AltOutArr(:,:,:) = AltPQmark(:,:,:);
end

%% Extract ranged array by using RefMetrics, Pseudo-metrics and GT-based metrics
NewRefAltArr(:,:) = zeros(num); %10
for ii = 1:num
        TwoDrefAltArr(:,:) = AltOutArr(ii,:,:);
        NewRefAltArr(:,:) = TwoDrefAltArr(:,:) + NewRefAltArr(:,:); 
end

for jj = 1:num
    NewRefAltArr(jj, num + 1) = sum(NewRefAltArr(jj,:));
end