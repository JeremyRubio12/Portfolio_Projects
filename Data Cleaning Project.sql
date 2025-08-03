/*  Cleaning Data in SQL */
use House_Project

SELECT * 
FROM NashvilleHousing

--- Standardize date format

SELECT SaleDate
FROM NashvilleHousing
WHERE TRY_CONVERT(date,SaleDate) IS NULL


ALTER TABLE NashvilleHousing
ADD SaleDateConverted date;

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(date,SaleDate)

SELECT SaleDate,SaleDateConverted
FROM NashvilleHousing

--- Populate the property address data

SELECT PropertyAddress
FROM NashvilleHousing

SELECT *
FROM NashvilleHousing
WHERE PropertyAddress IS NULL

-- Using a selfjoin to find which other row matches with the columns that are null in the PropertyAddress Column
-- If the other rows have the same ID means both should have the same same
-- We use ISNULL to match those 
SELECT a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
     on a.ParcelID = b.ParcelID
	 AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


-- Using an update statement to update the address with ISNULL
-- Using ISNULL will return the matching propertyadress for the NULL values and assign them the propertyAddress
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
     on a.ParcelID = b.ParcelID
	 AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL



--- Breaking address into individual columns (Address, City,State)

SELECT PropertyAddress
FROM NashvilleHousing

SELECT PropertyAddress,SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1 ) as 'Address'
FROM NashvilleHousing

SELECT PropertyAddress,SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1,LEN(PropertyAddress) ) as City
FROM NashvilleHousing


ALTER TABLE NashvilleHousing
ADD Address varchar(50);

UPDATE NashvilleHousing
SET Address = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1 )

ALTER TABLE NashvilleHousing
ADD City nvarchar(20);

UPDATE NashvilleHousing
SET City = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1,LEN(PropertyAddress))

SELECT *
FROM NashvilleHousing



SELECT PARSENAME(REPLACE(OwnerAddress,',','.'),1),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),3)
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress varchar(50);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity varchar(50);

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE NashvilleHousing
ADD OwnerSplitState varchar(50);

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)




--- Change Y and N to Yes and No in 'SoldAsVacant' field

select distinct SoldAsVacant
FROM NashvilleHousing


SELECT SoldAsVacant,COUNT(SoldAsVacant)
FROM NashvilleHousing
GROUP BY SoldAsVacant

SELECT 
CASE 
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END
FROM NashvilleHousing


UPDATE NashvilleHousing
SET SoldAsVacant =
CASE 
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END


---- Remove Duplicates ----- 


WITH RowNumCTE AS (
SELECT *,ROW_NUMBER() OVER (
		PARTITION BY ParcelID,
					 PropertyAddress,
					 SaleDate,
					 SalePrice,
					 LegalReference
					 ORDER BY UniqueID) as row_num
FROM NashvilleHousing
)
SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress


WITH RowNumCTE AS (
SELECT *,ROW_NUMBER() OVER (
		PARTITION BY ParcelID,
					 PropertyAddress,
					 SaleDate,
					 SalePrice,
					 LegalReference
					 ORDER BY UniqueID) as row_num
FROM NashvilleHousing
)
DELETE
FROM RowNumCTE
WHERE row_num > 1


select *
from NashvilleHousing


-- Delete unuse columns

ALTER TABLE NashvilleHousing
DROP COLUMN PropertyAddress,OwnerAddress,SaleDate,TaxDistrict

SELECT *
FROM NashvilleHousing