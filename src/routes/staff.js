const express = require('express');
const router = express.Router();
const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcrypt');

const prisma = new PrismaClient();

const convertToDate = (dateString) => {
  if (!dateString) return null;
  const [year, month, day] = dateString.split('-');
  return new Date(year, month - 1, day).toISOString();
};

// GET all staff
router.get('/', async (req, res) => {
  try {
    const staff = await prisma.staff.findMany();
    res.json(staff);
  } catch (error) {
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST create new staff member
router.post('/', async (req, res) => {
  try {
    const { name, lname, email, password, contact_information, phoneNo, mailing_address, date_of_birth, gender, qualifications, availability } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);

    const newStaff = await prisma.staff.create({
      data: {
        name,
        lname,
        email,
        password: hashedPassword,
        contact_information,
        phoneNo,
        mailing_address,
        date_of_birth: convertToDate(date_of_birth),
        gender,
        qualifications,
        availability
      }
    });

    res.status(201).json(newStaff);
  } catch (error) {
    console.error('Error creating staff:', error);
    res.status(500).json({ error: 'Failed to create staff' });
  }
});

// GET a specific staff member by ID
router.get('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const staff = await prisma.staff.findUnique({
      where: { staff_id: parseInt(id) },
    });
    if (staff) {
      res.json(staff);
    } else {
      res.status(404).json({ message: 'Staff member not found' });
    }
  } catch (error) {
    console.error('Error fetching staff member:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// DELETE a staff member by ID
router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const staff = await prisma.staff.delete({
      where: { staff_id: parseInt(id) }
    });
    res.status(200).json({ message: 'Staff deleted successfully', staff });
  } catch (error) {
    console.error('Error deleting staff member:', error);
    res.status(500).json({ error: 'Failed to delete staff member' });
  }
});

// PUT - Update a staff member completely
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { name, lname, email, password, contact_information, phoneNo, mailing_address, date_of_birth, gender, qualifications, availability } = req.body;
  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    const updatedStaff = await prisma.staff.update({
      where: { staff_id: parseInt(id) },
      data: {
        name,
        lname,
        email,
        password: hashedPassword,
        contact_information,
        phoneNo,
        mailing_address,
        date_of_birth: convertToDate(date_of_birth),
        gender,
        qualifications,
        availability
      }
    });
    res.json(updatedStaff);
  } catch (error) {
    console.error('Error updating staff member:', error);
    res.status(500).json({ error: 'Failed to update staff member' });
  }
});

// PATCH - Partially update a staff member
router.patch('/:id', async (req, res) => {
  const { id } = req.params;
  const updateData = { ...req.body };

  // Optionally handle password updates
  if (updateData.password) {
    updateData.password = await bcrypt.hash(updateData.password, 10);
  }

  // Handle date conversion for date_of_birth
  if (updateData.date_of_birth) {
    updateData.date_of_birth = convertToDate(updateData.date_of_birth);
  }

  try {
    const updatedStaff = await prisma.staff.update({
      where: { staff_id: parseInt(id) },
      data: updateData
    });
    res.json(updatedStaff);
  } catch (error) {
    console.error('Error partially updating staff member:', error);
    res.status(500).json({ error: 'Failed to partially update staff member' });
  }
});

module.exports = router;
